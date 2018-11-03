require "test_helper"

class ManageSettingsTest < ActionDispatch::IntegrationTest
  test "User should be able to alter the FROM_EMAIL on the settings page" do
    login_as users(:john)

    visit root_path
    click_link "Settings"

    fill_in "setting[from_email]", with: "new_email@example.com"
    click_button "Save settings"

    assert_equal "new_email@example.com", Setting.get(:from_email)
  end

  test "User should be enforced to update the settings if not all required settings are present" do
    login_as users(:john)

    Setting.destroy_all

    visit root_path

    assert_equal settings_path, current_path
  end
end
