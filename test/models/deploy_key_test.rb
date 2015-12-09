require 'test_helper'

class DeployKeyTest < ActiveSupport::TestCase
  should belong_to :server

  should validate_presence_of :name
  should validate_presence_of :key

  test "#name= should parameterize the given value" do
    deploy_key = DeployKey.new(name: "name with space")
    assert_equal "name-with-space", deploy_key.name
  end
end
