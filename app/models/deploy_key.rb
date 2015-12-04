class DeployKey < ActiveRecord::Base
  belongs_to :server

  validates :name, :key, presence: true
end
