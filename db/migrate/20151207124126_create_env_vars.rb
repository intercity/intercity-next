class CreateEnvVars < ActiveRecord::Migration
  def change
    create_table :env_vars do |t|
      t.string :key
      t.string :value
      t.references :app, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
