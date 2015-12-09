require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of :email
  should validate_presence_of :password
  should validate_uniqueness_of :email

  test "Is lowercases the email in the setter" do
    user = User.new(email: "John@example.com")
    assert_equal "john@example.com", user.email
  end
end
