class AddTotpSecretToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :totp_secret, :string
  end
end
