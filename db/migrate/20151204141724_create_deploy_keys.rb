class CreateDeployKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :deploy_keys do |t|
      t.string :name
      t.text :key
      t.references :server, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
