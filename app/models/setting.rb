class Setting < ApplicationRecord
  validates :from_email, presence: true
  validates :from_email, email_format: true, if: -> { from_email.present? }

  def self.get(value)
    Setting.first_or_initialize.send(value)
  rescue NoMethodError
    raise ActiveRecord::RecordNotFound, "Unknown value"
  end
end
