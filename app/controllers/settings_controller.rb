class SettingsController < ApplicationController
  skip_before_action :validate_settings

  def edit
    @settings = Setting.first_or_initialize
  end

  def update
    @settings = Setting.first_or_initialize
    if @settings.update(settings_params)
      flash[:success] = "Settings have been saved"
      redirect_to edit_settings_path
    else
      render :edit
    end
  end

  private

  def settings_params
    params.require(:setting).permit(:from_email, :enable_smtp, :smtp_address, :smtp_port,
                                    :smtp_username, :smtp_password, :smtp_domain)
  end
end
