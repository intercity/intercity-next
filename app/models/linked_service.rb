class LinkedService < ActiveRecord::Base
  belongs_to :app
  belongs_to :service

  enum status: { installing: 0, installed: 1 }
end
