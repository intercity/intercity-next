class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|
      t.references :server, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
