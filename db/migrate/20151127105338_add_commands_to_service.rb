class AddCommandsToService < ActiveRecord::Migration
  def change
    add_column :services, :commands, :json
  end
end
