class RemoveGitUrlFromService < ActiveRecord::Migration
  def change
    remove_column :services, :git_url, :string
  end
end
