require "test_helper"

class DomainsControllerTest < ActionController::TestCase
  setup do
    login_user(users(:john))
  end

  test "GET index should be successfull" do
    app = apps(:example)

    get :index, server_id: app.server, app_id: app.id

    assert_response :success
  end

  test "POST create should create a new domain" do
    app = apps(:example)

    assert_difference "app.domains.count" do
      AddDomainJob.expects(:perform_later)
      xhr :post, :create, server_id: app.server, app_id: app.id, domain: { name: "example.org" }
    end

    assert_response :success
  end

  test "DELETE destroy should remove an domain" do
    app = apps(:example)
    domain = domains(:example)

    assert_difference "app.domains.count", -1 do
      DeleteDomainJob.expects(:perform_later)
      xhr :delete, :destroy, server_id: app.server, app_id: app, id: domain
    end
  end
end
