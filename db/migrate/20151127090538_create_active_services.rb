class CreateActiveServices < ActiveRecord::Migration
  def change
    create_table :active_services do |t|
      t.references :service, index: true, foreign_key: true
      t.references :server, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
