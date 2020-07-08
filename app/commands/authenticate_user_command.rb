class AuthenticateUserCommand < BaseCommand
  private

  attr_reader :email, :password, :username

  def initialize(email, password)
    @email = email
    @username = username
    @password = password
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def password_valid?
    user && user.authenticate(password)
  end

  def payload
    if password_valid?
      if user.email_confirmed
        @result = JwtService.encode(contents)
      else
        errors.add(:base, ('Cuenta no verificada, revisa tu email'))
      end
    else
      errors.add(:base, ('Email o password incorrectos'))
    end
  end

  def contents
    {
      user_id: user.id,
      email: user.email,
      username: user.username,
      expiration: 24.hours.from_now.to_i
    }
  end
end