require "test_helper"

class FirstLaunchTest < ActionDispatch::IntegrationTest
  test "When there are no users in the system, you should see the onboarding page" do
    User.destroy_all

    visit root_path

    fill_in "user[email]", with: "user@example.com"
    fill_in "user[password]", with: "secret"
    click_button "Create first account"

    assert_equal root_path, current_path
  end
end
