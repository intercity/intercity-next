class AddConnectedToServer < ActiveRecord::Migration[5.0]
  def change
    add_column :servers, :connected, :boolean, default: false
  end
end
