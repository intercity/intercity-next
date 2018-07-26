class AddTypeToBackup < ActiveRecord::Migration[5.0]
  def change
    add_column :backups, :backup_type, :integer, default: 0
  end
end
