class AddLetsencryptEmailToApp < ActiveRecord::Migration[5.1]
  def change
    add_column :apps, :letsencrypt_email, :string
    add_column :apps, :letsencrypt_enabled, :boolean
  end
end
