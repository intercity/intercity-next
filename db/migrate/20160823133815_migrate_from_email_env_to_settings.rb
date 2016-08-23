class MigrateFromEmailEnvToSettings < ActiveRecord::Migration[5.0]
  def change
    setting = Setting.first_or_initialize
    return unless setting.from_email.nil?
    setting.update(from_email: ENV["FROM_EMAIL"])
  end
end
