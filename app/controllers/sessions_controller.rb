class SessionsController < ApplicationController
  def new
    @title = 'Sign In'
    redirect_to dashboard_path if signed_in?
  end

  def create
    params_permitted = session_params
    @email = params_permitted[:email]
    user = User.find_by(email: @email.downcase)
    if user && user.authenticate(params_permitted[:password])
      sign_in user
      redirect_to dashboard_path
    else
      flash.now[:alert] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to www_url
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
