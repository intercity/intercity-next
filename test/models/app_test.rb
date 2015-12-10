require 'test_helper'

class AppTest < ActiveSupport::TestCase
  should belong_to :server
  should have_many :linked_services
  should have_many(:services).through(:linked_services)
  should have_many :env_vars
  should have_many :domains

  should validate_presence_of :name
end
