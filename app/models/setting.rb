class Setting < ApplicationRecord
  validates :from_email, presence: true
  validates :from_email, email_format: true, if: -> { from_email.present? }
  validates :smtp_address, :smtp_port, :smtp_username, :smtp_password,
            :smtp_domain, presence: true, if: -> { smtp_enabled? }

  def self.get(value)
    Setting.first_or_initialize.send(value)
  rescue NoMethodError
    raise ActiveRecord::RecordNotFound, "Unknown value: #{value}"
  end

  def smtp_enabled?
    respond_to?(:enable_smtp) && enable_smtp
  end
end
