class AddDomainToApp < ActiveRecord::Migration
  def change
    add_column :apps, :domain, :string
  end
end
