require 'test_helper'

class CreateNewAppTest < ActionDispatch::IntegrationTest
  test "User should be able to create a new app on a given server" do
    skip "We this will be enabled later on"
    visit root_path

    server = servers(:example)

    within "#server_#{server.id}" do
      click_link "Apps"
    end

    click_link "Add new app"

    fill_in "app[name]", with: "Example app"

    assert_difference "server.reload.apps.count" do
      click_button "Create app"
    end
  end
end
