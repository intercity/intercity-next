class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :validate_two_factor_key

  layout "login"

  def new; end

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user
      @user.generate_reset_password_token
      ApplicationMailer.reset_password(@user).deliver_later
    end

    redirect_to root_path, notice: "If your email address exists in our database, "\
      "you will receive a password recovery link at your email address in a few minutes."
  end

  def edit
    @token = params[:id]
    @user = User.where("reset_password_token_expires_at > ?", Time.now).
            find_by!(reset_password_token: params[:id])
  end

  def update
    @token = params[:id]
    @user = User.where("reset_password_token_expires_at > ?", Time.now).
            find_by!(reset_password_token: params[:id])
    @user.validate_password = true

    if @user.update(change_password_params)
      redirect_to root_path, notice: "Password was successfully updated."
    else
      render :edit
    end
  end

  private

  def change_password_params
    params.require(:user).permit(:password)
  end
end
