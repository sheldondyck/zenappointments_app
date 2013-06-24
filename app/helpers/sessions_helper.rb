module SessionsHelper
  SUPER_SESSION_SECRET = 'ABCD1234'

  def logged_in?
    cookies[:super_secure_login_credentials] == SUPER_SESSION_SECRET
  end
end
