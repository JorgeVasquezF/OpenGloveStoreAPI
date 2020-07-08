class UserMailer < ApplicationMailer
	def welcome_email
	    @user = params[:user]
	    @app = params[:app]
	    mail(to: @user.email, subject: 'Revisión de aplicación')
	end
	def error_app
	    @user = params[:user]
		@app = params[:app]
		@comment = params[:comment]
	    mail(to: @user.email, subject: 'Problemas con tu aplicación')
	end
	def success_app
	    @user = params[:user]
		@app = params[:app]
		@comment = params[:comment]
	    mail(to: @user.email, subject: 'Excelente')
	end
	def reset_password
	    @user = params[:user]
		@token = params[:token]
	    mail(to: @user.email, subject: 'Recuperar password')
	end
	def registration_confirmation
		@user = params[:user]
		mail(to: @user.email, subject: 'Confirmación de registro')
	end
end
