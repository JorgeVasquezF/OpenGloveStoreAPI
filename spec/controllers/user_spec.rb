require 'rails_helper'

module Api
  	module V1
		RSpec.describe UsersController, type: :controller do

		  describe "GET #index" do
		    it "returns http success" do
		      user = FactoryBot.create(:user)
		      get :index
		      expect(response).to have_http_status(:success)
		    end
		  end
		end
	end
end

 module Api
  	module V1
		RSpec.describe UsersController, type: :controller do

		  describe "POST #create" do
		    it "returns http success" do
		      post :create, :params => { :user => {:username => "shoxo", :email => "shoxo@gmail.com", :password => "123"}, :format => :json}
		      expect(response.content_type).to eq "application/json"
		    end
		  end
		end
	end
end

 module Api
  	module V1
		RSpec.describe UsersController, type: :controller do

		  describe "POST #show" do
		    it "returns http success" do
		      get :show, :params => { id: 1, :user => {:id => 1}, :format => :json}
		      expect(response.content_type).to eq "application/json"
		    end
		  end
		end
	end
end
	
module Api
  	module V1
		RSpec.describe UsersController, type: :controller do

		  describe "POST #update" do
		    it "returns http success" do
		    user2 = FactoryBot.create(:user)
	        put :update, :params => { id: user2.id, :user => {:username => "shoxo2", :email => "shoxo@gmail.com", :password => "123"}, :format => :json}
		    end
		  end
		end
	end
end

module Api
  	module V1
		RSpec.describe UsersController, type: :controller do

		  describe "POST #delete" do
		    it "returns http success" do
		    user2 = FactoryBot.create(:user)
	        delete :destroy, :params => { id: user2.id, :format => :json}
		    end
		  end
		end
	end
end
