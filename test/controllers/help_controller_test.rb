require "test_helper"

class HelpControllerTest < ActionController::TestCase
  test "#index should be successfull" do
    login_user users(:john)
    get :index
    assert_response :success
  end

  test "#show should be successfull" do
    login_user users(:john)
    get :show, category: "deploy", file: "ruby_on_rails"
    assert_response :success
  end

  test "#show should render the root readme if going outside doc folder" do
    login_user users(:john)
    get :show, category: "../../", file: "README"
    assert response.body =~ /How to deploy/
    assert_response :success
  end
end
