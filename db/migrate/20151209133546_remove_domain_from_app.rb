class RemoveDomainFromApp < ActiveRecord::Migration
  def change
    remove_column :apps, :domain, :string
  end
end
