class ApplicationMailer < ActionMailer::Base
  default from: Setting.get(:from_email)
  layout "mailer"

  def initialize
    super
    if Setting.get(:enable_smtp?)
      ActionMailer::Base.delivery_method = :smtp
      ActionMailer::Base.smtp_settings.merge!(smtp_settings)
    else
      ActionMailer::Base.delivery_method = Rails.configuration.x.default_email_delivery_method
    end
  end

  protected

  def smtp_settings
    {
      address: Setting.get(:smtp_address),
      port: Setting.get(:smtp_port),
      enable_starttls_auto: true,
      user_name: Setting.get(:smtp_username),
      password: Setting.get(:smtp_password),
      domain: Setting.get(:smtp_domain)
    }
  end
end
