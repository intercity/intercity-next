class UsersController < ApplicationController
  skip_before_action :require_login, only: [:activate, :confirm]
  layout "login", only: [:activate, :confirm]

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

  def activate
    @user = User.load_from_activation_token(params[:token])
    redirect_to root_path unless @user.present?
  end

  def confirm
    if @user = User.load_from_activation_token(params[:token])
      if @user.update(confirmation_params)
        @user.activate!
        flash[:success] = "Your account is now activated."
        redirect_to login_url
      else
        render :activate
      end
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def confirmation_params
    params.require(:user).permit(:password)
  end
end
