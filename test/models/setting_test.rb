require "test_helper"

class SettingTest < ActiveSupport::TestCase
  should validate_presence_of :from_email

  test ".get should return a setting value" do
    setting = settings(:example)

    assert_equal setting.from_email, Setting.get(:from_email)
  end

  test ".get should return a ActiveRecordNotFound for an invalid value" do
    assert_raise ActiveRecord::RecordNotFound do
      Setting.get(:unknown_value)
    end
  end
end
