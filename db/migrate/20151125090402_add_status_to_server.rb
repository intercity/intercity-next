class AddStatusToServer < ActiveRecord::Migration
  def change
    add_column :servers, :status, :integer, default: 0
  end
end
