require 'test_helper'

class DeployKeyTest < ActiveSupport::TestCase
  should belong_to :server

  should validate_presence_of :name
  should validate_presence_of :key
end
