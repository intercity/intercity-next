class AddUpdatingToServer < ActiveRecord::Migration[5.0]
  def change
    add_column :servers, :updating, :boolean, default: false
  end
end
