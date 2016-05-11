class Users::TwoStepVerificationsController < ApplicationController
  def new
    redirect_to two_step_verification_path if current_user.two_factor_auth_enabled?
    ensure_totp_secret
    @totp = totp
    @qrcode = RQRCode::QRCode.new(@totp.provisioning_uri(current_user.email))
  end

  def create
    verify_code_and_change_status(enabled: true)
    session[:passed_two_factor_auth] = true
    redirect_to new_two_step_verification_path
  end

  def show
    redirect_to new_two_step_verification_path unless current_user.two_factor_auth_enabled?
  end

  def destroy
    verify_code_and_change_status(enabled: false)
    redirect_to new_two_step_verification_path
  end

  private

  def ensure_totp_secret
    return if current_user.totp_secret.present?
    current_user.update_attribute(:totp_secret, ROTP::Base32.random_base32)
  end

  def verify_code_and_change_status(enabled:)
    code = params[:two_factor_auth][:code]
    if totp.verify(code)
      current_user.update_attribute(:two_factor_auth_enabled, enabled)
    else
      flash[:error] = "Verification code seems to be invalid"
    end
  end

  def totp
    @totp ||= ROTP::TOTP.new(current_user.totp_secret, issuer: "Intercity")
  end
end
