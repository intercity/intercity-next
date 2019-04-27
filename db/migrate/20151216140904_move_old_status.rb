class MoveOldStatus < ActiveRecord::Migration[5.0]
  class Server < ActiveRecord::Base; end

  def up
    Server.where(status: 1).each { |s| s.update(status: 30) }
    Server.where(status: 2).each { |s| s.update(status: 40) }
  end

  def down
    Server.where(status: 30).each { |s| s.update(status: 1) }
    Server.where(status: 40).each { |s| s.update(status: 2) }
  end
end
