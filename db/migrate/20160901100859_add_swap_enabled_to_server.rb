class AddSwapEnabledToServer < ActiveRecord::Migration[5.0]
  def change
    add_column :servers, :swap_enabled, :boolean, default: false
  end
end
