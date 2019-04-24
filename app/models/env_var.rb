class EnvVar < ApplicationRecord
  belongs_to :app

  validates :key, presence: true, uniqueness: { scope: :app_id }

  attr_accessor :apply_immediately

  def apply_immediately?
    apply_immediately == "1"
  end
end
