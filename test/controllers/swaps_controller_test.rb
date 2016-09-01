require "test_helper"

class SwapsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  test "GET show should be successful" do
    login_as users(:john)

    get server_swap_path(servers(:example))

    assert_response :success
  end

  test "POST create should enable swap on the server" do
    login_as users(:john)
    server = servers(:example)

    refute server.swap_enabled?, "Swap should be disabled"

    assert_enqueued_with(job: EnableSwapJob, args: [server]) do
      post server_swap_path(server)
    end

    assert server.reload.swap_enabled?, "Swap should be enabled"
    assert_response :redirect
  end

  test "DELETE destroy should disable swap on the server" do
    login_as users(:john)
    server = servers(:example).tap { |s| s.update(swap_enabled: true) }

    assert server.swap_enabled?, "Swap should be enabled"

    assert_enqueued_with(job: DisableSwapJob, args: [server]) do
      delete server_swap_path(server)
    end

    refute server.reload.swap_enabled?, "Swap should be disabled"
    assert_response :redirect
  end
end
