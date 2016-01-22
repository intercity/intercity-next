require "test_helper"

class UserActivationTest < ActionDispatch::IntegrationTest
  test "User activation should be successfull" do
    user = users(:jane)
    visit edit_user_activation_path(user.activation_token)

    fill_in "user[password]", with: "secret_password"
    click_button "Finish your account"

    assert_equal login_path, current_path
    assert user.reload.activation_token.blank?
  end
end
