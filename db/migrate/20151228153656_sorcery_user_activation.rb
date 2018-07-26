class SorceryUserActivation < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :activation_token, :string, default: nil
    add_index :users, :activation_token
  end
end
