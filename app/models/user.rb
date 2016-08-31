class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_secure_token :reset_password_token

  attr_accessor :validate_password

  validates :email, presence: true
  validates :email, uniqueness: true, email_format: true, if: -> { email.present? }
  validates :password, presence: true, if: -> { validate_password }
  validates :password, length: { minimum: 8 }, if: -> { password.present? }

  def email=(value)
    self[:email] = value.downcase unless value.nil?
  end

  def generate_activation_token
    self[:activation_token] = SecureRandom.uuid
  end

  def generate_reset_password_token
    regenerate_reset_password_token
    update(reset_password_token_expires_at: 1.day.from_now)
  end

  def activate!
    update(activation_token: nil)
  end

  def self.load_from_activation_token(token)
    find_by(activation_token: token)
  end
end
