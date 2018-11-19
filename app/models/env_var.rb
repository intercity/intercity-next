class EnvVar < ApplicationRecord
  belongs_to :app

  validates :key, presence: true, uniqueness: { scope: :app_id }

  attr_accessor :apply_immediately
end
