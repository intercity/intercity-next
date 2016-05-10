class TwoFactorAuthsController < ApplicationController
  skip_before_action :validate_two_factor_key
  layout "login"

  def new
  end

  def create
    code = params[:two_factor_auth][:code]
    if totp.verify(code)
      session[:passed_two_factor_auth] = true
      redirect_to root_path
    else
      flash.now[:error] = "Verification code seems to be invalid"
      render :new
    end
  end

  private

  def totp
    @totp ||= ROTP::TOTP.new(current_user.totp_secret, issuer: "Intercity")
  end
end
