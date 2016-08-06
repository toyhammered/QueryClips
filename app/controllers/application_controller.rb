class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # 3rd Party mixins
  include Pundit

  # Local mixins
  include SessionsHelper

  def preflight_check
    @preflight_check = false

    # Check for user-configurable items
    if DatabaseConnection.count < 1
      @preflight_check = true
    else
      if SavedQuery.count < 1
        @preflight_check = true
      end
    end

    # Check for environment configuration options
    if ENV['HOST'].nil?
      @preflight_check = true
    end

    smtp_vars = [
      'SMTP_HOST',
      'SMTP_PORT',
      'SENDGRID_USERNAME',
      'SENDGRID_PASSWORD',
      'SMTP_DOMAIN'
    ]
    if smtp_vars.any? { |var| ENV[var].nil? }
      @preflight_check = true
      @preflight_check_smtp = true
    end

    # TODO: after unprototyping Preflight check, we should
    # also include optional environment variables here
  end
end
