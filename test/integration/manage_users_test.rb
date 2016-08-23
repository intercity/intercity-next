require "test_helper"

class ManageUsersTest < IntegrationTest
  test "I want to be able to add new users to the system" do
    use_javascript

    login_as users(:john)
    visit root_path

    click_link "Users"

    fill_in "user[email]", with: "testemail@example.com"
    click_button "Add new user"

    assert page.has_content?("testemail@example.com")
  end

  test "I want to be able to remove a user from the system" do
    use_javascript

    user = users(:jane)

    login_as users(:john)
    visit root_path

    click_link "Users"

    within "#user_#{user.id}" do
      click_link "Remove"
    end

    # We need to give jquery a bit of time to let the record fadeout and
    # disappear
    sleep 0.4

    refute page.has_content?("jane@example.com"), "Page should not have Jane anymore"
  end
end
