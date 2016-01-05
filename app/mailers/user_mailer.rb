class UserMailer < ApplicationMailer
  def activation(user)
    @user = user
    @url = activate_users_url(token: user.activation_token)
    mail(to: user.email, subject: "Welcome to Intercity")
  end
end
