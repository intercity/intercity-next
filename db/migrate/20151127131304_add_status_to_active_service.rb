class AddStatusToActiveService < ActiveRecord::Migration[5.0]
  def change
    add_column :active_services, :status, :integer, default: 0
  end
end
