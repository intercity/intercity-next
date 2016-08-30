require 'test_helper'

class AppTest < ActiveSupport::TestCase
  should belong_to :server
  should have_many :linked_services
  should have_many(:services).through(:linked_services)
  should have_many(:env_vars).dependent(:destroy)
  should have_many(:domains).dependent(:destroy)
  should have_many(:backups).dependent(:destroy)

  should validate_presence_of :name
  should validate_uniqueness_of(:name).scoped_to(:server_id)

  test "#service_status(service) returns a status code for the service" do
    app = apps(:example).tap { |a| a.services.destroy_all }
    redis = services(:redis)

    assert_equal "new", app.service_status(redis)

    app.services << redis
    assert_equal "installing", app.service_status(redis)

    LinkedService.find_by(app: app, service: redis).update(status: "installed")
    assert_equal "installed", app.service_status(redis)
  end

  test "#linked_service(service) gets the given service type" do
    app = apps(:example)
    redis = services(:redis)
    redis_example = linked_services(:redis_example)

    assert_equal redis_example, app.linked_service(redis)
  end
end
