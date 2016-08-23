require "test_helper"

class SettingsControllerTest < ActionDispatch::IntegrationTest
  test "GET edit should be successful" do
    login_as users(:john)

    get edit_settings_path

    assert_response :success
  end

  test "PATCH update should be successful" do
    login_as users(:john)

    new_email_value = "new_email@example.com"

    refute_equal new_email_value, settings(:example).from_email

    patch settings_path, params: { setting: { from_email: "new_email@example.com" } }

    assert_equal new_email_value, settings(:example).reload.from_email
  end
end
