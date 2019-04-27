class AddBusyToApp < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :busy, :boolean, default: false
  end
end
