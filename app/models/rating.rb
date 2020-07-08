class Rating < ApplicationRecord
	belongs_to :user
	belongs_to :app
	#validates :rating, presence: true
	#validates :comment, presence: true
end
