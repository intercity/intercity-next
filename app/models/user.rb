class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email, :password, presence: true
  validates :email, uniqueness: true, if: -> { email.present? }

  def email=(value)
    self[:email] = value.downcase unless value.nil?
  end
end
