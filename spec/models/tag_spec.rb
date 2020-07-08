require "rails_helper"

RSpec.describe Tag, :type => :model do
	before(:all) do
		@tag1 = create(:tag)
	end
	it "is valid with valid attributes" do
		expect(@tag1).to be_valid
	end

	it "is not valid without a rating" do 
		tag2 = build(:tag, name: nil)
		expect(tag2).to_not be_valid
	end

end