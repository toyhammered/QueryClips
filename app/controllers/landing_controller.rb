class LandingController < ApplicationController
  def index
    redirect_to queries_path if logged_in?
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @readme = markdown.render(File.read(Rails.root.join("README.md")))
    @user = User.new
  end
end
