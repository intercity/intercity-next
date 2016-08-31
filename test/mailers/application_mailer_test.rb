require 'test_helper'

class ApplicationMailerTest < ActionMailer::TestCase
  test "activation" do
    user = users(:john)
    user.activation_token = "1234"
    mail = ApplicationMailer.activation(user)
    assert_equal "Welcome to Intercity", mail.subject
    assert_equal [Setting.get(:from_email)], mail.from
    assert_equal [user.email], mail.to
  end

  test ".reset_password" do
    user = users(:john)
    user.generate_reset_password_token

    mail = ApplicationMailer.reset_password(user)

    assert_equal "Please reset your password", mail.subject
  end
end
