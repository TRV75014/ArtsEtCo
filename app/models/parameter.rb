class Parameter < ActiveRecord::Base
  validates :nbRectBlack, presence: true, in: 1..10
  validates :nbRectWhite, presence: true, in: 1..10

  belongs_to :users
end
