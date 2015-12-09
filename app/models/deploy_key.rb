class DeployKey < ActiveRecord::Base
  belongs_to :server

  validates :name, :key, presence: true

  def name=(value)
    self[:name] = value.parameterize unless value.nil?
  end
end
