class Tag < ApplicationRecord
	has_and_belongs_to_many :apps
	validates :name, presence: true
	def to_s
    	name
  	end
end
