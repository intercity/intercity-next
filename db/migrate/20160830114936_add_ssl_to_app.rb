class AddSslToApp < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :ssl_key, :text
    add_column :apps, :ssl_cert, :text
    add_column :apps, :ssl_enabled, :boolean, default: false
  end
end
