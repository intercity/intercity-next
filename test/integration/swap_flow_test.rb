require "test_helper"

class SwapFlowTest < ActionDispatch::IntegrationTest
  test "A user should be able to enable swap on a server" do
    login_as users(:john)
    visit server_path(servers(:example))

    click_link "Swap"

    click_link "Enable swap"

    assert page.has_content?("Swap is enabled"), "Page should say that swap is enabled"
  end

  test "A user should be able to disable swap" do
    servers(:example).update(swap_enabled: true)
    login_as users(:john)

    visit server_path(servers(:example))

    click_link "Swap"

    click_link "Disable swap"

    assert page.has_content?("Swap is disabled"), "Page should say that swap is disabled"
  end
end
