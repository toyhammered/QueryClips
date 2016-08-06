# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  address: ENV['SMTP_HOST'],
  port:    ENV['SMTP_PORT'],
  authentication: :plain,
  user_name: ENV['SENDGRID_USERNAME'],
  password: ENV['SENDGRID_PASSWORD'],
  domain: ENV['SMTP_DOMAIN'],
  enable_starttls_auto: true
}
