class AddRsaKeyToServer < ActiveRecord::Migration
  def change
    add_column :servers, :rsa_key_public, :text
    add_column :servers, :rsa_key_private, :text
  end
end
