require 'test_helper'

class IntegrationsTest < ActionDispatch::IntegrationTest
  test "User should be able to create an integration" do
    use_javascript
    login_as users(:john)

    visit root_path
    click_link "Integrations"
    fill_in "integration[name]", with: "My API"
    click_button "Add new application"

    within ".integrations" do
      assert page.has_content? "My API"
    end
  end

  test "User should be able to reveal an integration access token" do
    use_javascript
    login_as users(:john)

    visit root_path
    click_link "Integrations"

    integration = integrations(:api_application)

    within "tr#integration_#{integration.id}" do
      click_on "Click to reveal"
    end

    assert page.has_content?(integration.access_token)
  end
end
