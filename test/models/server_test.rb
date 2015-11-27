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
end
