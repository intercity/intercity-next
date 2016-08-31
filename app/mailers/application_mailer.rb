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

  def activation(user)
    @user = user
    @url = edit_user_activation_url(user.activation_token)
    mail(to: @user.email, subject: "Welcome to Intercity")
  end

  def reset_password(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email, subject: "Please reset your password")
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
