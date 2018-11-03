class IntegrationsController < ApplicationController
  def index
    @integrations = Integration.all
    @integration = Integration.new
  end

  def create
    @integration = Integration.new(integration_params)
    @integration.save
  end

  def destroy
    @integration = Integration.find(params[:id])
    @integration.destroy
  end

  def reveal
    @integration = Integration.find(params[:id])
  end

  private

  def integration_params
    params.require(:integration).permit(:name)
  end
end
