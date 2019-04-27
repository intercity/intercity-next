class CreateDomains < ActiveRecord::Migration[5.0]
  def change
    create_table :domains do |t|
      t.references :app, index: true, foreign_key: true
      t.string :name
    end
  end
end
