class LandingController < ApplicationController
  def index
    redirect_to queries_path if logged_in?
  end
end
