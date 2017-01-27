class Server < ActiveRecord::Base
  has_many :apps, dependent: :destroy
  has_many :active_services, dependent: :destroy
  has_many :services, through: :active_services
  has_many :deploy_keys, dependent: :destroy

  before_create :create_rsa_key

  enum status: { fresh: 0, connected: 10, installing: 20, up: 30, down: 40 }

  validates :name, :ip, :username, presence: true

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

  def up_to_date?
    VersionParser.parse(dokku_version) >= VersionParser.parse(latest_dokku_version)
  end

  def latest_dokku_version
    "v0.7.1".freeze
  end

  def formatted_status
    case status
    when "up", "down"
      status
    when "fresh", "installing", "connected"
      "setup_not_finished"
    end
  end

  private

  def create_rsa_key
    key = OpenSSL::PKey::RSA.new(1024)
    self.rsa_key_public = key.public_key.to_pem
    self.rsa_key_private = key.to_pem
  end
end
