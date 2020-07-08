module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]
      skip_before_action :authenticate_user, only: [:create, :index, :update, :confirm_email]
      

      # GET /users
      def index
        @users = User.all

        render json: @users
      end

      # GET /users/1
      def show
        render json: @user
      end
      # POST /users
      def create
        @user = User.new(user_params)
        if @user.save
          @user.set_confirmation_token
          @user.save(validate: false)
          puts @user.confirm_token
          UserMailer.with(user: @user).registration_confirmation.deliver_later
          puts @user.confirm_token
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
      # GET /:token/confirm_email
      def confirm_email
        user = User.find_by_confirm_token(params[:token])
        if user
          user.validate_email
          user.save(validate: false)
          return render json: {status: 'Email verificado !'}, status: :ok
        else
          return render json: {status: 'El usuario no existe o token expirado'}
       end
      end
      # PATCH/PUT /users/1
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /users/1
      def destroy
        @user.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def user_params
          params.permit(:id, :username, :email, :password)
        end
    end
  end
end