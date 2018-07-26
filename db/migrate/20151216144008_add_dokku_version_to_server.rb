class AddDokkuVersionToServer < ActiveRecord::Migration[5.0]
  def change
    add_column :servers, :dokku_version, :string
  end
end
