class CreateEnvVars < ActiveRecord::Migration[5.0]
  def change
    create_table :env_vars do |t|
      t.string :key
      t.string :value
      t.references :app, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
