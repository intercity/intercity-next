class AddDomainToApp < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :domain, :string
  end
end
