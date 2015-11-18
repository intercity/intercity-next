class AddConnectedToServer < ActiveRecord::Migration
  def change
    add_column :servers, :connected, :boolean, default: false
  end
end
