class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :redirect_if_first_user
  before_action :validate_two_factor_key
  before_action :validate_settings

  protected

  def not_authenticated
    redirect_to login_path
  end

  def redirect_if_first_user
    redirect_to welcome_path unless User.any?
  end

  def validate_two_factor_key
    return unless current_user.two_factor_auth_enabled?
    return if session[:passed_two_factor_auth]
    redirect_to two_factor_path
  end

  def validate_settings
    return if Setting.first_or_initialize.valid?
    flash[:error] = "You need to verify some settings, required fields are marked with '*'"
    redirect_to settings_path
  end
end
