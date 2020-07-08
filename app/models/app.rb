class App < ApplicationRecord
	has_and_belongs_to_many :tags
	has_many :check
	has_many :user, through: :check
	has_many :rating
	validates :name, presence: true
	validates :description, presence: true
	validates :git_url, presence: true
	validates :os, presence: true
	validates :documentation, presence: true

	include PgSearch::Model
    pg_search_scope :search, against: [:name, :description],
    using: {
        tsearch: {
            prefix: true
        }
    }
	def to_s
		name
	end
end
