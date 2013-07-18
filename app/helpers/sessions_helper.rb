module SessionsHelper
  SUPER_SESSION_SECRET = 'ABCD1234'

  def signed_in?
    cookies[:super_secure_signin_credentials] == SUPER_SESSION_SECRET
  end
end
