require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "activation" do
    user = users(:john)
    user.activation_token = "1234"
    mail = UserMailer.activation(user)
    assert_equal "Welcome to Intercity", mail.subject
    assert_equal [ENV['FROM_EMAIL']], mail.from
    assert_equal [user.email], mail.to
  end
end
