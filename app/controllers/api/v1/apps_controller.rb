module Api
  module V1
    class AppsController < ApplicationController
      include ActionController::MimeResponds
      before_action :set_app, only: [:addTag, :show, :update, :destroy]
      skip_before_action :authenticate_user, only: [:index, :showReleases, :show, :filterByTag, :search, :getTagsApp, :appsByUser]
      # GET /apps
      def index
        @apps = App.paginate(page: params[:page], per_page: 3).order("created_at DESC").where(:verified => [0,2])
        render json: @apps
      end
      # GET apps/:id/releases
      def showReleases
        url = App.find(params[:id]).git_url
        client = Octokit::Client.new(:access_token => Rails.application.credentials.github)
        response = client.releases(url)
        render json: response
      end
      # GET /apps/1
      def show
        @app = App.find(params[:id])
        client = Octokit::Client.new(:access_token => Rails.application.credentials.github)
        url = @app.git_url
        response = client.latest_release(url) 
        last = response["published_at"]
        last2 = last.to_s
        if @app.last_release != last2
          @app.published = false
          @app.verified = 2
          @app.last_release = last2
          @app.save
          @ownerApp = Check.where("role = ? AND app_id = ?", 1, @app.id)
          @userCheck = Check.where("role = ? AND app_id = ?", 2, @app.id)
          @userCheck.each do |x|
            x.approved = false
            x.disapproved = false
            x.save
          end
          @user = User.find(@ownerApp[0].user_id)
          puts @user.inspect
          email(@user,@app)
        end
        render :json => @app.to_json(:include => { :check => {:include => {:user => { :only => :username}  }}})
      end
      #POST /apps/usercheck
      def userCheck
         @user = Check.where("user_id = ? AND app_id = ?", params[:userid], params[:appid])
         if @user != nil
          render json: @user
         else
          render json: nil
         end
      end
      def email(user, app) 
        @usersRev = User.where.not(id: user.id)
        puts @usersRev.inspect
        app.user << @usersRev
        @prueba = Check.where(app_id: app.id).where.not(user_id: user.id)
        @prueba.each do |r|
          r.role = 2
          r.save
        end
        @usersRev.each do |t|
          UserMailer.with(user: t, app: @app).welcome_email.deliver_later
        end
      end
      # POST /apps
      def create
        begin  # "try" block
          url = params[:git_url]
          client = Octokit::Client.new(:access_token => Rails.application.credentials.github)     
          response = client.latest_release(url)
          @app = App.new(app_params)
          if @app.save
              @app.user << User.find(params[:user_id])
              @user = User.find(params[:user_id])
              @ownerApp = Check.find_by(app_id: @app.id)
              @ownerApp.role = 1
              @ownerApp.save
              @app.last_release = response["published_at"]
              @app.save
              email(@user,@app)
              render json: @app, status: :created
          else
            render json: @app.errors, status: :unprocessable_entity
          end
        rescue StandardError => e
            puts e.inspect
            render json: { status: 102 }  
        ensure # will always get executed
            puts 'Always gets executed.'
        end 
      end
      # POST /apps/approve
      def approveApp
        @checkUser = Check.where("user_id = ? AND app_id = ?", params[:user_id], params[:app_id])
        @app = App.find(params[:app_id])
        @checksApp = Check.where(app_id: params[:app_id])
        contadorDisapproved = 0
        contadorApproved = 0
        if params[:approved] == true
          @checkUser[0].approved = true
          @checkUser[0].comment = params[:comment]
          @checkUser[0].save 
          @checksApp.each do |r|
            if r.role == 1
              @userApp = User.find(r.user_id)
              UserMailer.with(user: @userApp, app: @app, comment: params[:comment]).success_app.deliver_later
            end
            if r.approved == true
              contadorApproved = contadorApproved + 1
            end
          end
          if contadorApproved == 2
            @app.published = true
            @app.save
          end
        else
          @checkUser[0].disapproved = true
          @checkUser[0].comment = params[:comment]
          @checkUser[0].save 
          @checksApp.each do |r|
            if r.role == 1
              @userApp = User.find(r.user_id)
              UserMailer.with(user: @userApp, app: @app, comment: params[:comment]).error_app.deliver_later
            end
            if r.disapproved == true
              contadorDisapproved = contadorDisapproved + 1
            end
          end
          if contadorDisapproved == 2
            @app.verified = 1
            @app.save
          end
        end 
      end
      # POST /apps/1/tags
      def addTag
        tag = Tag.find_by(name: params[:name])
        puts tag
        @app.tags << tag
        render json: tag, status: :ok
      end
      # POST /apps/filter
      def filterByTag
        tag = Tag.find_by(name: params[:name])
        @apps = App.joins(:tags).where(tags: {id: tag.id}) 
        render json: @apps
      end
      # POST /apps/search
      def search
        @apps = App.search(params[:name])
        render json: @apps
      end   
      # PATCH/PUT /apps/1
      def update
        if @app.update(app_params)
          render json: @app
        else
          render json: @app.errors, status: :unprocessable_entity
        end
      end

      # DELETE /apps/1
      def destroy
        @app.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_app
          @app = App.find(params[:id])
          
        end

        # Only allow a trusted parameter "white list" through.
        def app_params
          params.permit(:id, :name, :description, :git_url, :video_url, :documentation, :published, :image_url, :os)
        end
        
    
    end
  end
end