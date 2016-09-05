class MarkExistingServicesAsLinked < ActiveRecord::Migration[5.0]
  def change
    # Mark all legacy linked services as linked (We did not keep track of status)
    LinkedService.update_all(status: 1)
  end
end
