class User < ApplicationRecord
	has_many :check
	has_many :app, through: :check	
	has_secure_password
	has_many :rating
	validates :username, uniqueness: true
 	validates :email, uniqueness: true
	def generate_password_token!
		self.reset_password_token = generate_token
		self.reset_password_sent_at = Time.now.utc
		save!
		return self.reset_password_token
	end
	
	def password_token_valid?
		(self.reset_password_sent_at + 4.hours) > Time.now.utc
	end
	
	def reset_password!(password)
		self.reset_password_token = nil
		self.password = password
		save!
	end
	def set_confirmation_token
		if self.confirm_token.blank?
			self.confirm_token = SecureRandom.urlsafe_base64.to_s
		end
	end 
	def validate_email
		self.email_confirmed = true
		self.confirm_token = nil
	end
	private
	def generate_token
		SecureRandom.hex(10)
	end 
	
	
	
	
end
