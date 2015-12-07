require 'test_helper'

class EnvVarTest < ActiveSupport::TestCase
  should belong_to :app

  should validate_presence_of :key
  should validate_uniqueness_of(:key).scoped_to(:app_id)
end
