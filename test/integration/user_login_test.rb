require "test_helper"

class UserLoginTest < IntegrationTest
  test "User login should be successfull" do
    visit root_path

    assert_equal login_path, current_path

    fill_in "login[email]", with: "john@example.com"
    fill_in "login[password]", with: "secret"
    click_button "Login"

    assert_equal root_path, current_path
  end
end
