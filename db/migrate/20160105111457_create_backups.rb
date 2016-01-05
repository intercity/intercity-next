class CreateBackups < ActiveRecord::Migration
  def change
    create_table :backups do |t|
      t.string :filename
      t.references :service, index: true, foreign_key: true
      t.references :app, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
