class AddStatusToLinkedService < ActiveRecord::Migration[5.0]
  def change
    add_column :linked_services, :status, :integer, default: 0
  end
end
