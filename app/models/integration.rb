class Integration < ApplicationRecord
  validates :name, presence: true
  has_secure_token :access_token
end
