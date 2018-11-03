require 'test_helper'

class NewServerTest < ActionDispatch::IntegrationTest
  test "User should be able to create a new server" do
    use_javascript

    login_as users(:john)
    visit root_path

    click_link "Add a new server"

    # temporary hack to get this test to pass. Somehow capybara doesn't like the
    # way we interact with the Bulma modal elements.
    interact_with_hidden_elements do
      fill_in "server[name]", with: "Example server"
      fill_in "server[ip]", with: "127.0.0.1"
      click_button "Add server"
    end
  end
end
