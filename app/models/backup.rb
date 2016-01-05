class Backup < ActiveRecord::Base
  belongs_to :service
  belongs_to :app
end
