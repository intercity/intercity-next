class Server < ActiveRecord::Base
  has_many :apps, dependent: :destroy
  has_many :active_services, dependent: :destroy
  has_many :services, through: :active_services
  has_many :deploy_keys, dependent: :destroy

  before_create :create_rsa_key

  enum status: { fresh: 0, connected: 10, installing: 20, up: 30, down: 40 }

  def service?(service)
    services.include?(service)
  end

  def service(service)
    active_services.find_by!(service: service)
  end

  def service_status(service)
    if service?(service)
      service(service).status
    else
      "new"
    end
  end

  def linkable_services
    services.where(linkable: true)
  end

  private

  def create_rsa_key
    key = OpenSSL::PKey::RSA.new(1024)
    self.rsa_key_public = key.public_key.to_pem
    self.rsa_key_private = key.to_pem
  end
end
