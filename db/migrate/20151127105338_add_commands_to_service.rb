class AddCommandsToService < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :commands, :json
  end
end
