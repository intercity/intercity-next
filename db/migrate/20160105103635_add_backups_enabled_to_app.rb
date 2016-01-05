class AddBackupsEnabledToApp < ActiveRecord::Migration
  def change
    add_column :apps, :backups_enabled, :boolean, default: :false
  end
end
