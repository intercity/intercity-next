class App < ActiveRecord::Base
  belongs_to :server

  has_many :linked_services, dependent: :destroy
  has_many :services, through: :linked_services
  has_many :env_vars, dependent: :destroy
  has_many :domains, dependent: :destroy
  has_many :backups, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :server_id }

  validate :valid_ssl, if: :ssl_enabled?
  validates :ssl_cert, :ssl_key, presence: true, if: :ssl_enabled?

  def clean_name
    name.parameterize
  end

  def linked_service?(service)
    services.include?(service)
  end

  def service_status(service)
    if linked_service?(service)
      linked_service(service).status
    else
      "new"
    end
  end

  def linked_service(service)
    linked_services.find_by!(service: service)
  end

  private

  def valid_ssl
    return unless ssl_enabled?
    errors.add(:ssl_key, " is invalid") if ssl_key.present? &&
                                           ssl_key.match(/-----BEGIN RSA PRIVATE KEY-----/).nil?

    errors.add(:ssl_cert, " is invalid") if ssl_cert.present? &&
                                            ssl_cert.match(/-----BEGIN CERTIFICATE-----/).nil?
  end
end
