class App < ActiveRecord::Base
  belongs_to :server

  validates :name, :domain, presence: true, uniqueness: true

  def clean_name
    name.parameterize
  end
end
