class SessionsController < ApplicationController
  def new
    @title = 'Sign In'
  end

  def create
    user = User.find_by(email: get_session_params[:email].downcase)
    if user && user.authenticate(get_session_params[:password])
      sign_in user
      redirect_to appointments_path
    else
      flash.now[:error] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    sign_out
    # TODO: redirect to www
    redirect_to signin_path
  end

  private
    def get_session_params
      params.require(:session).permit(:email, :password)
    end
end
