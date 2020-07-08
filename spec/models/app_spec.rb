require "rails_helper"

RSpec.describe Rating, :type => :model do
	before(:all) do
		user = create(:user)
		@app1 = create(:app, user_ids: user.id)
	end
	it "is valid with valid attributes" do
		expect(@app1).to be_valid
	end

	it "is not valid without a app" do 
		user = create(:user)
		app2 = build(:app, user_ids: user.id, name: nil)
		expect(app2).to_not be_valid
	end

	it "is not valid without an comment" do
		user = create(:user)
		app2 = build(:app, user_ids: user.id, description: nil)
		expect(app2).to_not be_valid
	end

	it "is not valid without an comment" do
		user = create(:user)
		app2 = build(:app, user_ids: user.id, documentation: nil)
		expect(app2).to_not be_valid
	end

	it "is not valid without an comment" do
		user = create(:user)
		app2 = build(:app, user_ids: user.id, os: nil)
		expect(app2).to_not be_valid
	end

	it "is not valid without an comment" do
		user = create(:user)
		app2 = build(:app, user_ids: user.id, git_url: nil)
		expect(app2).to_not be_valid
	end

	it "is not valid without an comment" do
		user = create(:user)
		app2 = build(:app, user_ids: user.id, video_url: nil)
		expect(app2).to be_valid
	end

	it "is not valid without an comment" do
		user = create(:user)
		app2 = build(:app, user_ids: user.id, image_url: nil)
		expect(app2).to be_valid
	end

end