class App < ActiveRecord::Base
  belongs_to :server

  has_many :linked_services, dependent: :destroy
  has_many :services, through: :linked_services

  validates :name, :domain, presence: true, uniqueness: true

  def clean_name
    name.parameterize
  end

  def has_service?(service)
    services.include?(service)
  end
end
