class CreateIntegrations < ActiveRecord::Migration[5.1]
  def change
    create_table :integrations do |t|
      t.string :name
      t.string :access_token

      t.timestamps
    end
  end
end
