class CreateServerLoadReadings < ActiveRecord::Migration[5.0]
  def change
    create_table :server_load_readings do |t|
      t.references :server
      t.decimal :cpu, precision: 4, scale: 2
      t.decimal :memory, precision: 4, scale: 2
      t.decimal :disk, precision: 4, scale: 2

      t.timestamps null: false
    end
  end
end
