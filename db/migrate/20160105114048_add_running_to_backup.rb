class AddRunningToBackup < ActiveRecord::Migration[5.0]
  def change
    add_column :backups, :running, :boolean, default: false
  end
end
