class RemoveGitUrlFromService < ActiveRecord::Migration[5.0]
  def change
    remove_column :services, :git_url, :string
  end
end
