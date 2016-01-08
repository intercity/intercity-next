class AddLinkableToService < ActiveRecord::Migration
  def change
    add_column :services, :linkable, :boolean, default: false
  end
end
