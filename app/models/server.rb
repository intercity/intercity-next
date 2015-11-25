class Server < ActiveRecord::Base
  has_many :apps, dependent: :destroy

  before_create :create_rsa_key

  enum status: { setup: 0, up: 1, down: 2 }

  private

  def create_rsa_key
    key = OpenSSL::PKey::RSA.new(1024)
    self.rsa_key_public = key.public_key.to_pem
    self.rsa_key_private = key.to_pem
  end
end
