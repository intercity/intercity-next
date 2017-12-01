class ActiveService < ApplicationRecord
  belongs_to :service
  belongs_to :server

  enum status: { installing: 0, installed: 1 }
end
