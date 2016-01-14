class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessor :skip_password_validation

  validates :email, presence: true
  validates :email, uniqueness: true, email_format: true, if: -> { email.present? }
  validates :password, presence: true, unless: -> { skip_password_validation }

  def email=(value)
    self[:email] = value.downcase unless value.nil?
  end

  def generate_activation_token
    self[:activation_token] = SecureRandom.uuid
  end

  def activate!
    update(activation_token: nil, skip_password_validation: true)
  end

  def self.load_from_activation_token(token)
    find_by(activation_token: token)
  end
end
