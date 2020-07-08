module Api
  module V1
    class RatingsController < ApplicationController
      include ActionController::MimeResponds
      before_action :set_rating, only: [:show, :update, :destroy]
      skip_before_action :authenticate_user, only: [:index, :ratingByApp, :ratingAverage, :show]
      # GET /ratings
      def index
        @ratings = Rating.all
        render json: @ratings
      end

      # GET /ratings/1
      def show
      	@user = @rating.user
        render json: @user
      end


      # POST /ratings
      def create
        @rating = Rating.new(rating_params)
        @rating.ip = request.remote_ip
        puts @rating.rating
        puts @rating.ip
        if @rating.save
          render json: @rating, status: :created
        else
          render json: @rating.errors, status: :unprocessable_entity
        end
      end
      # GET /ratings/app/:id
      def ratingByApp
        @rating = Rating.paginate(page: params[:page], per_page: 3).where(app_id: params[:id])
        ratings = Rating.paginate(page: params[:page], per_page: 3).where(app_id: params[:id]).order("created_at DESC")
        puts "DSADSA"
        
        total = @rating.total_pages
      	@avg = @rating.average(:rating)	
		    render json: { 
          rating: ratings.as_json(include: {user: {only: :username}}),
          total: total
        } 
      end
      # GET /ratings/average/:id
      def ratingAverage 
      	@rating = Rating.where(app_id: params[:id])
      	@avg = @rating.average(:rating)
        ip = request.remote_ip
        
        puts ip
        
      	render :json => @avg
      		
      end	
      # PATCH/PUT /ratings/1
      def update
        if @rating.update(rating_params)
          render json: @rating
        else
          render json: @rating.errors, status: :unprocessable_entity
        end
      end

      # DELETE /ratings/1
      def destroy
        @rating.destroy
      end

      private
        # Use callbacks to share common setup or constraints btween actions.
        def set_rating
          @rating = Rating.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def rating_params
          params.permit(:rating, :comment, :date, :app_id, :user_id)
        end
    end
  end
end