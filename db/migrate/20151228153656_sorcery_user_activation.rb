class SorceryUserActivation < ActiveRecord::Migration
  def change
    add_column :users, :activation_token, :string, default: nil
    add_index :users, :activation_token
  end
end
