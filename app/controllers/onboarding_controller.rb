class OnboardingController < ApplicationController
  skip_before_action :require_login
  skip_before_action :redirect_if_first_user

  before_action :redirect_unless_first_user

  layout "login"

  def index
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def redirect_unless_first_user
    redirect_to root_path if User.any?
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
