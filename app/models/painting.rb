class Painting < ActiveRecord::Base
  ratyrate_rateable 'Note'
  belongs_to :users
end
