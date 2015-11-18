class AddBusyToApp < ActiveRecord::Migration
  def change
    add_column :apps, :busy, :boolean, default: false
  end
end
