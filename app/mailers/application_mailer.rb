class ApplicationMailer < ActionMailer::Base
  default from: Setting.get(:from_email)
  layout "mailer"
end
