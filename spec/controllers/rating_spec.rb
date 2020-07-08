require 'rails_helper'

module Api
  	module V1
		RSpec.describe RatingsController, type: :controller do

		  describe "GET #index" do
		    it "returns http success" do
		      get :index
		      expect(response).to have_http_status(:success)
		    end
		  end
		end
	end
end


module Api
  	module V1
		RSpec.describe RatingsController, type: :controller do

		  describe "GET #show" do
		    it "returns http success" do
		       user1 = create(:user)
		      rating = create(:rating, user: user1)
		      get :show, :params => { id: rating.id, :format => :json}
		      expect(response.content_type).to eq "application/json"
		    end
		  end
		end
	end
end
