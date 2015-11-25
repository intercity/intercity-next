require 'test_helper'

class AppOverviewTest < ActionDispatch::IntegrationTest
  test "User should see a list of all the apps for a given server" do
    skip "Disabled for now"
    visit root_path

    server = servers(:example)

    within "#server_#{server.id}" do
      click_link "Apps"
    end

    within ".apps" do
      assert page.has_selector?(".app", count: server.apps.count),
        "Page should have #{server.apps.count}"
    end
  end
end
