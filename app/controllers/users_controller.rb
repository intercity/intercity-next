class UsersController < ApplicationController
  def index
    @user = User.new
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @user.generate_activation_token
    ApplicationMailer.activation(@user).deliver_later if @user.save
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy if User.count > 1
  end

  def resend_activation_mail
    @user = User.where.not(activation_token: nil).find(params[:id])
    ApplicationMailer.activation(@user).deliver_later
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
