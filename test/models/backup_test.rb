require 'test_helper'

class BackupTest < ActiveSupport::TestCase
  check_for_valid_fixtures :backup
  should belong_to :service
  should belong_to :app

  should validate_presence_of :app
  should validate_presence_of :service
  should validate_presence_of :backup_type
end
