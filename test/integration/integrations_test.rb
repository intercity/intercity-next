require 'test_helper'

class IntegrationsTest < ActionDispatch::IntegrationTest
  test "User should be able to create an integration" do
    use_javascript
    login_as users(:john)

    visit root_path
    click_link "Integrations"
    fill_in "integration[name]", with: "My API"
    click_button "Add new integration"

    within ".integrations" do
      assert page.has_content? "My API"
    end
  end
end
