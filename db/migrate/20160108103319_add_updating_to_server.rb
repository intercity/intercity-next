class AddUpdatingToServer < ActiveRecord::Migration
  def change
    add_column :servers, :updating, :boolean, default: false
  end
end
