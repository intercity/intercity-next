class AddTwoFactorAuthEnabledToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :two_factor_auth_enabled, :boolean, default: false
  end
end
