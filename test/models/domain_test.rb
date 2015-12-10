require 'test_helper'

class DomainTest < ActiveSupport::TestCase
  should belong_to :app

  should validate_presence_of :name
  should validate_uniqueness_of(:name).scoped_to(:app_id)
end
