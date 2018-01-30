class Painting < ActiveRecord::Base
  validates :mark in: 1..5  
  belongs_to :users
end
