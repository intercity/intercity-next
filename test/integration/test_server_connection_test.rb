require 'test_helper'

class TestServerConnectionTest < ActionDispatch::IntegrationTest
  test "When the server is connected properly, the test should tell so" do
    use_javascript

    visit root_path

    server = servers(:example)

    SshExecution.any_instance.stubs(:run_ssh).returns("works")

    within "#server_#{server.id}" do
      click_link "Test server connection"
      assert page.has_content?("Connection successfull"), "Page should say the connection was successfull"
    end
  end

  test "When the server can't connect, it should say so" do
    use_javascript

    visit root_path

    server = servers(:example)

    SshExecution.any_instance.stubs(:ssh_timeout).returns(1)

    within "#server_#{server.id}" do
      click_link "Test server connection"
      assert page.has_content?("Could not connect"), "Page should say the connection was successfull"
    end
  end
end
