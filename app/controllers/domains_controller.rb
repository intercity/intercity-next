class DomainsController < ApplicationController
  def index
    @app = App.find_by!(id: params[:app_id], server: params[:server_id])
    @domain = Domain.new
  end

  def create
    @app = App.find_by!(id: params[:app_id], server: params[:server_id])
    @domain = @app.domains.new(domain_params)
    AddDomainJob.perform_later(@app, @domain.name) if @domain.save
  end

  def destroy
    @app = App.find_by!(id: params[:app_id], server: params[:server_id])
    @domain = @app.domains.find(params[:id])
    DeleteDomainJob.perform_later(@app, @domain.name) if @domain.destroy
  end

  private

  def domain_params
    params.require(:domain).permit(:name)
  end
end
