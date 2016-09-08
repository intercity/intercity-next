class AddServerResourcesToServer < ActiveRecord::Migration[5.0]
  def change
    add_column :servers, :total_ram, :integer
    add_column :servers, :total_disk, :integer
    add_column :servers, :total_cpu, :integer
  end
end
