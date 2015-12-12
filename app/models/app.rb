class App < ActiveRecord::Base
  belongs_to :server

  has_many :linked_services, dependent: :destroy
  has_many :services, through: :linked_services
  has_many :env_vars, dependent: :destroy
  has_many :domains, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def clean_name
    name.parameterize
  end

  def service?(service)
    services.include?(service)
  end
end
