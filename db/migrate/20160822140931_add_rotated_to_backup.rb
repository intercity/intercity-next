class AddRotatedToBackup < ActiveRecord::Migration[5.0]
  def change
    add_column :backups, :rotated, :boolean, default: false
  end
end
