require "test_helper"

class EmptyStateTest < ActionDispatch::IntegrationTest
  test "When there are no users in the system, you should see the onboarding page" do
    User.destroy_all

    visit root_path

    fill_in "user[email]", with: "user@example.com"
    fill_in "user[password]", with: "secret_password"
    click_button "Create first account"

    assert_equal root_path, current_path
  end

  test "When there are no servers, you should see the server blank slate" do
    Server.destroy_all

    login_as users(:john)
    visit root_path

    assert page.has_content?("Looks like you don’t have any servers."),
      "Page should have the empty state text"
  end
end
