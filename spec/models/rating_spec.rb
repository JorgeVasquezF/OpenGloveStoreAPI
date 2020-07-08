require "rails_helper"

RSpec.describe Rating, :type => :model do
	before(:all) do
		user = create(:user)
		puts user.id
		@rating1 = create(:rating, user: user)
	end
	it "is valid with valid attributes" do
		expect(@rating1).to be_valid
	end

	it "is not valid without a rating" do 
		rating2 = create(:rating, rating: nil)
		expect(rating2).to be_valid
	end

	it "is not valid without an comment" do
		rating2 = create(:rating, comment: nil)
		expect(rating2).to be_valid
	end
end