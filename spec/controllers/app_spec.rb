require 'rails_helper'

module Api
  	module V1
		RSpec.describe AppsController, type: :controller do

		  describe "GET #index" do
		    it "returns http success" do
		      get :index
		      expect(response).to have_http_status(:success)
		    end
		  end
		end
	end
end
begin
module Api
 	module V1
		RSpec.describe AppsController, type: :controller do

		  describe "GET #showReleases" do
		    it "returns http success" do
		      app3 = FactoryBot.create(:app)
		      get :showReleases, params: { :id => app3.id }
		      expect(response).to have_http_status(:success)
		    end
		  end
		end
	end
end
end
module Api
  	module V1
		RSpec.describe AppsController, type: :controller do

		  describe "POST #create" do
		    it "returns http success" do
		     
		      user = FactoryBot.create(:user)
		      post :create, :params => { :app => { :name => "rainbow", :description => "hola", :git_url => "https://github.com/JorgeVasquezF/APIOpenGlove/", 
		      :video_url => "dsad", :documentation => "doc", :image_url => "dasdas", :os => "Windows", :user_id => user.id }, :format => :json}
		      expect(response.content_type).to eq "application/json"
		    end
		  end
		end
	end
end

module Api
  	module V1
		RSpec.describe AppsController, type: :controller do

		  describe "GET #search" do
		    it "returns http success" do
		      post :search, :params => { :app => {:name => "dota"}, :format => :json}
		      expect(response.content_type).to eq "application/json"
		    end
		  end
		end
	end
end


module Api
  	module V1
		RSpec.describe AppsController, type: :controller do

		  describe "POST #show" do
		  	before(:all) do
			      @user1 = FactoryBot.create(:user)
			      @user2 = FactoryBot.create(:user)
			      @user3 = FactoryBot.create(:user)
			      @app4 = create(:app, name: "rainbow", description: "sdas", git_url: "https://github.com/JorgeVasquezF/APIOpenGlove/", video_url: "sdas",
			      	documentation: "doc", image_url: "sdas", os: "windows", user_ids: @user1.id)
			      @check = FactoryBot.create(:check, user_id: @user1.id, app_id: @app4.id)
			  end
		    it "returns http success" do 
		      
		      get :show, :params => { id: @app4.id, :format => :json}
		      expect(response.content_type).to eq "application/json"
		    end
		  end
		end
	end
end

 module Api
  	module V1
		RSpec.describe AppsController, type: :controller do

		  describe "POST #addTag" do
		  	before(:all) do
			      @tag= FactoryBot.create(:tag)
			     
			  end
		    it "returns http success" do
		      post :addTag, :params => { id: 1, :tag => {:name => @tag.name}, :format => :json}
		      expect(response.content_type).to eq "application/json"
		    end
		  end
		end
	end
end

module Api
  	module V1
		RSpec.describe AppsController, type: :controller do

		  describe "POST #update" do
		  	before(:all) do
			      @user1 = FactoryBot.create(:user)
			      @app4 = create(:app, name: "rainbow", description: "sdas", git_url: "https://github.com/JorgeVasquezF/APIOpenGlove/", video_url: "sdas",
			      	documentation: "doc", image_url: "sdas", os: "windows", user_ids: @user1.id)
			  end
		    it "returns http success" do
	        put :update, :params => { id: @app4.id, :user => {:name => "rainbow2"}, :format => :json}
		    end
		  end
		end
	end
end
