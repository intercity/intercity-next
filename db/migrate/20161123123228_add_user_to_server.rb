class AddUserToServer < ActiveRecord::Migration[5.0]
  def change
    add_column :servers, :username, :string, default: "root"
  end
end
