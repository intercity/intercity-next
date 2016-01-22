class UserActivationController < ApplicationController
  skip_before_action :require_login

  layout "login"

  def edit
    @user = User.load_from_activation_token(params[:id])
    redirect_to root_path unless @user.present?
  end

  def update
    if @user = User.load_from_activation_token(params[:id])
      if @user.update(activation_params)
        @user.activate!
        flash[:success] = "Your account is now activated."
        redirect_to login_url
      else
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  private

  def activation_params
    params.require(:user).permit(:password)
  end
end
