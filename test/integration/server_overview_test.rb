require 'test_helper'

class ServerOverviewTest < ActionDispatch::IntegrationTest
  test "Dashboard should list all the servers" do
    visit root_path

    within ".servers" do
      assert page.has_selector?(".server", count: Server.count),
        "Page should list #{Server.count} servers"
    end
  end

  test "When I click on Show SSH key I should see the public SSH key for that server" do
    visit root_path

    server = Server.first
    ssh_key = SSHKey.new(server.rsa_key_private)

    within "#server_#{server.id}" do
      click_link "Show public SSH key"
    end

    assert page.has_content?(ssh_key.ssh_public_key), "Page should show the public SSH key"
  end
end
