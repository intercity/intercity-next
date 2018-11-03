class IntegrationsController < ApplicationController
  def index
    @integrations = Integration.all
    @integration = Integration.new
  end
end
