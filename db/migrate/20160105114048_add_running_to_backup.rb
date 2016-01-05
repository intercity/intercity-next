class AddRunningToBackup < ActiveRecord::Migration
  def change
    add_column :backups, :running, :boolean, default: false
  end
end
