class AddTypeToBackup < ActiveRecord::Migration
  def change
    add_column :backups, :backup_type, :integer, default: 0
  end
end
