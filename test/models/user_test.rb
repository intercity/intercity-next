require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of :email
  should validate_uniqueness_of :email
  should_not allow_value("hi").for(:email)
  should allow_value("john@example.nl").for(:email)
  should allow_value("john+doe@example.com").for(:email)
  should allow_value("john@example.city").for(:email)
  should validate_length_of(:password).is_at_least(8)

  test "It lowercases the email in the setter" do
    user = User.new(email: "John@example.com")
    assert_equal "john@example.com", user.email
  end

  test ".generate_activation_token generates a activation_token" do
    user = users(:john)
    user.generate_activation_token
    assert user.activation_token.present?
  end

  test "If validate_password is set it validates the password" do
    user = users(:john)
    user.password = nil
    assert user.valid?

    user.validate_password = true
    refute user.valid?
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
