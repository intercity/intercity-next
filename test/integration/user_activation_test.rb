require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  test "User activation should be successfull" do
    user = users(:jane)
    visit activate_users_path(token: user.activation_token)

    fill_in "user[password]", with: "secret"
    click_button "Finish your account"

    assert_equal login_path, current_path
    assert user.reload.activation_token.blank?
  end
end
