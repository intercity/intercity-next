class AddDokkuVersionToServer < ActiveRecord::Migration
  def change
    add_column :servers, :dokku_version, :string
  end
end
