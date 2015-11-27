class ActiveService < ActiveRecord::Base
  belongs_to :service
  belongs_to :server
end
