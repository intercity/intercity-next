require 'test_helper'

class AppOverviewTest < IntegrationTest
  test "User should see a list of all the apps for a given server" do
    login_as users(:john)
    visit root_path

    server = servers(:example)

    within "#server_#{server.id}" do
      click_link "#{server.name}"
    end

    within ".apps" do
      assert page.has_selector?(".app", count: server.apps.count),
        "Page should have #{server.apps.count}"
    end
  end
end
