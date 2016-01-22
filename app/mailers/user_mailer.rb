class UserMailer < ApplicationMailer
  def activation(user)
    @user = user
    @url = edit_user_activation_url(user.activation_token)
    mail(to: user.email, subject: "Welcome to Intercity")
  end
end
