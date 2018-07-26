class AddInstallStepToServer < ActiveRecord::Migration[5.0]
  def change
    add_column :servers, :install_step, :integer, default: 1
  end
end
