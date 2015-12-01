require 'test_helper'

class ServerTest < ActiveSupport::TestCase
  should have_many :apps
  should have_many :active_services
  should have_many(:services).through(:active_services)

  test "It should create a RSA key on create" do
    server = Server.create!(name: "test", ip: "127.0.0.1")
    refute_nil server.rsa_key_public
    refute_nil server.rsa_key_private
  end

  test "#has_service?(service) tells if a server has a specific service installed" do
    server = servers(:example).tap { |s| s.services.destroy_all }
    redis = services(:redis)

    refute server.has_service?(redis), "Server should not have redis"

    server.services << redis
    assert server.has_service?(redis), "Server should have redis"
  end

  test "#service(service) gets the given service type" do
    server = servers(:example)
    redis = services(:redis)
    redis_example = active_services(:redis_example)

    assert_equal redis_example, server.service(redis)
  end

  test "#service_status(service) returns a status code for the service" do
    server = servers(:example).tap { |s| s.services.destroy_all }
    redis = services(:redis)

    assert_equal "new", server.service_status(redis)

    server.services << redis
    assert_equal "installing", server.service_status(redis)

    ActiveService.find_by(server: server, service: redis).update(status: "installed")
    assert_equal "installed", server.service_status(redis)
  end
end
