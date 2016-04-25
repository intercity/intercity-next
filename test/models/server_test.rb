require 'test_helper'

class ServerTest < ActiveSupport::TestCase
  should have_many(:apps).dependent(:destroy)
  should have_many(:active_services).dependent(:destroy)
  should have_many(:services).through(:active_services)
  should have_many(:deploy_keys).dependent(:destroy)
  should have_many(:server_load_readings).dependent(:destroy)

  test "It should create a RSA key on create" do
    server = Server.create!(name: "test", ip: "127.0.0.1")
    refute_nil server.rsa_key_public
    refute_nil server.rsa_key_private
  end

  test "#service?(service) tells if a server has a specific service installed" do
    server = servers(:example).tap { |s| s.services.destroy_all }
    redis = services(:redis)

    refute server.service?(redis), "Server should not have redis"

    server.services << redis
    assert server.service?(redis), "Server should have redis"
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

  test "#up_to_date? checks if the server is up to date with current dokku version" do
    outdated = Server.new(dokku_version: "v0.4.8")
    outdated.stubs(:latest_dokku_version).returns("v0.4.10")
    refute outdated.up_to_date?, "Server should be marked as not up to date"

    up_to_date = Server.new(dokku_version: "v0.4.10")
    up_to_date.stubs(:latest_dokku_version).returns("v0.4.10")
    assert up_to_date.up_to_date?, "Server should be marked as up to date"
  end
end
