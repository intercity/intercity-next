class AddStatusToActiveService < ActiveRecord::Migration
  def change
    add_column :active_services, :status, :integer, default: 0
  end
end
