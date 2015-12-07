class EnvVar < ActiveRecord::Base
  belongs_to :app

  validates :key, presence: true, uniqueness: { scope: :app_id }
end
