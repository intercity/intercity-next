class App < ActiveRecord::Base
  belongs_to :server

  has_many :linked_services, dependent: :destroy
  has_many :services, through: :linked_services
  has_many :env_vars, dependent: :destroy
  has_many :domains, dependent: :destroy
  has_many :backups, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :server_id }

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
end
