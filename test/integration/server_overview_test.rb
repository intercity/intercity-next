require 'test_helper'

class ServerOverviewTest < ActionDispatch::IntegrationTest
  test "Dashboard should list all the servers" do
    visit root_path

    within ".servers" do
      assert page.has_selector?(".server", count: Server.count),
        "Page should list #{Server.count} servers"
    end
  end
end
