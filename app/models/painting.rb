class Painting < ActiveRecord::Base
  validates :mark
  belongs_to :users
end
