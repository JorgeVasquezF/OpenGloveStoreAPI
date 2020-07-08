module Api
  module V1
    class PasswordsController < ApplicationController
        skip_before_action :authenticate_user, only: [:forgot, :reset]
        def forgot
            if params[:email].blank? 
              return render json: {error: 'Email no ingresado'}
            end
            user = User.find_by(email: params[:email])  
            if user.present?
              token = user.generate_password_token!
              UserMailer.with(user: user, token: token).reset_password.deliver_later 
              render json: {status: 'Código enviado !'}, status: :ok
            else
              render json: {error: 'Email no encontrado. Por favor revisa e intenta nuevamente.'}, status: :not_found
            end
          end
        
          def reset
            token = params[:token].to_s
        
            if params[:email].blank?
              return render json: {error: 'Token no ingresado'}
            end
            user = User.find_by(reset_password_token: token)
        
            if user.present? && user.password_token_valid?
              if user.reset_password!(params[:password])
                render json: {status: 'Password cambiada !'}, status: :ok
              else
                render json: {error: user.errors.full_messages}, status: :unprocessable_entity
              end
            else
              render json: {error:  'Token no válido o expirado. Intenta nuevamente.'}, status: :not_found
            end
          end
    end
  end
end