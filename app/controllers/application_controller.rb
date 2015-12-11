class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :redirect_if_first_user

  protected

  def not_authenticated
    redirect_to login_path
  end

  def redirect_if_first_user
    redirect_to welcome_path unless User.any?
  end
end
