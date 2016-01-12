require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of :email
  should validate_uniqueness_of :email

  test "It lowercases the email in the setter" do
    user = User.new(email: "John@example.com")
    assert_equal "john@example.com", user.email
  end

  test ".generate_activation_token generates a activation_token" do
    user = users(:john)
    user.generate_activation_token
    assert user.activation_token.present?
  end

  test "If skip_password_validation is set it skips the password validation" do
    user = users(:john)
    user.password = nil
    refute user.valid?

    user.skip_password_validation = true
    assert user.valid?
  end

  test ".activate! unsets the activation_token" do
    user = users(:john)
    user.generate_activation_token
    user.activate!

    assert user.activation_token.blank?
  end

  test ".load_from_activation_token finds the user with the given activation_token" do
    user = users(:jane)
    assert_equal User.load_from_activation_token(user.activation_token), user
  end
end
