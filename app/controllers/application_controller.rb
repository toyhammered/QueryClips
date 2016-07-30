class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # 3rd Party mixins
  include Pundit

  # Local mixins
  include SessionsHelper
end
