require 'rails_helper'

 module Api
  	module V1
		RSpec.describe TagsController, type: :controller do

		  describe "GET #show" do
		    it "returns http success" do
		      tag = FactoryBot.create(:tag)
		      get :show, params: { :id => 1 }
		      expect(response).to have_http_status(:success)
		    end
		  end
		end
	end
end

 module Api
  	module V1
		RSpec.describe TagsController, type: :controller do

		  describe "GET #index" do
		    it "returns http success" do
		      tag = FactoryBot.create(:tag)
		      get :index
		      expect(response).to have_http_status(:success)
		    end
		  end
		end
	end
end

 module Api
  	module V1
		RSpec.describe TagsController, type: :controller do

		  describe "GET #create" do
		    it "returns http success" do
		      post :create, :params => { :tag => {:name => "Deportes"}, :format => :json}
		      expect(response.content_type).to eq "application/json"
		    end
		  end
		end
	end
end

module Api
  	module V1
		RSpec.describe TagsController, type: :controller do

		  describe "POST #update" do
		    it "returns http success" do
	        put :update, :params => { id: 1, :user => {:name => "estrategia"}, :format => :json}
		    end
		  end
		end
	end
end

