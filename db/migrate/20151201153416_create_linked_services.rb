class CreateLinkedServices < ActiveRecord::Migration[5.0]
  def change
    create_table :linked_services do |t|
      t.references :app, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
