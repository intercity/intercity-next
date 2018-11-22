class AddLetsencryptEmailToApp < ActiveRecord::Migration[5.1]
  def change
    add_column :apps, :letsencrypt_email, :string
  end
end
