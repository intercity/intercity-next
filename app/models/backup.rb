class Backup < ActiveRecord::Base
  belongs_to :service
  belongs_to :app

  enum backup_type: { automatic: 0, manual: 1 }

  validates :app, :service, :backup_type, presence: true
end
