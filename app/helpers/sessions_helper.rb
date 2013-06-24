module SessionsHelper
  def logged_in?
    cookies[:super_secure_login_credentials] == 'abc123'
  end
end
