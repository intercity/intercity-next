class MigrateSmtpSettings < ActiveRecord::Migration[5.0]
  def change
    return if ENV["SMTP_ADDRESS"].nil?
    Setting.update(smtp_address: ENV["SMTP_ADDRESS"], smtp_port: ENV["SMTP_PORT"],
                   smtp_username: ENV["SMTP_USER_NAME"], smtp_password: ENV["SMTP_PASSWORD"],
                   smtp_domain: ENV["SMTP_DOMAIN"], enable_smtp: true)
  end
end
