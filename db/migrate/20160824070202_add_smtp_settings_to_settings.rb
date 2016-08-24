class AddSmtpSettingsToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :enable_smtp, :boolean, default: false
    add_column :settings, :smtp_address, :string
    add_column :settings, :smtp_port, :integer
    add_column :settings, :smtp_username, :string
    add_column :settings, :smtp_password, :string
    add_column :settings, :smtp_domain, :string
  end
end
