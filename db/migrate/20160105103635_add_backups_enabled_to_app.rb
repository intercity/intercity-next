class AddBackupsEnabledToApp < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :backups_enabled, :boolean, default: :false
  end
end
