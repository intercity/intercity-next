class DeployKey < ApplicationRecord
  belongs_to :server

  validates :name, :key, presence: true

  def name=(value)
    self[:name] = value.parameterize if value
  end
end
