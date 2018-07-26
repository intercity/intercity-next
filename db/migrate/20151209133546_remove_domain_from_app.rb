class RemoveDomainFromApp < ActiveRecord::Migration[5.0]
  def change
    remove_column :apps, :domain, :string
  end
end
