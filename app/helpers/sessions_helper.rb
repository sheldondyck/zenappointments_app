module SessionsHelper
  def signed_in?
    !current_user.nil?
  end

  def sign_in(user)
    signin_token = User.new_signin_token
    cookies.permanent[:signin_token] = signin_token
    user.update_attribute(:signin_token, User.encrypt(signin_token))
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:signin_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    signin_token = User.encrypt(cookies[:signin_token])
    @current_user ||= User.find_by(signin_token: signin_token)
  end
end
