require 'test_helper'

class ActiveServiceTest < ActiveSupport::TestCase
  should belong_to :service
  should belong_to :server
end
