class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :git_url
      t.boolean :active, default: false

      t.timestamps null: false
    end
  end
end
