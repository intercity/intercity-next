class AddInstallStepToServer < ActiveRecord::Migration
  def change
    add_column :servers, :install_step, :integer, default: 1
  end
end
