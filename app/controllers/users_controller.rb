class UsersController < ApplicationController
  def index
    @user = User.new
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @user.skip_password_validation = true
    @user.generate_activation_token
    UserMailer.activation(@user).deliver_later if @user.save
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
