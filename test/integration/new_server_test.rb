require 'test_helper'

class NewServerTest < ActionDispatch::IntegrationTest
  test "User should be able to create a new server" do
    login_as users(:john)
    visit root_path

    click_link "New server"

    fill_in "server[name]", with: "Example server"
    fill_in "server[ip]", with: "127.0.0.1"

    assert_difference "Server.count" do
      click_button "Create server"
    end

    assert_equal server_path(Server.last), current_path
  end
end
