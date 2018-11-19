class Apps::RestartsController < ServerBaseController
  def create
    @app = App.find(params[:app_id])
    RestartAppJob.perform_later(@app)
  end
end
