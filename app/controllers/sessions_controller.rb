class SessionsController < ApplicationController
  skip_before_action :require_login, except: :destroy
  layout "login"

  def new
  end

  def create
    user = User.find_by(email: params[:login][:email], activation_token: nil)
    if user && login(params[:login][:email], params[:login][:password])
      redirect_back_or_to root_path
    else
      flash.now[:error] = "Login failed"
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
