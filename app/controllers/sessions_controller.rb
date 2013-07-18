class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:session][:email] == 'foo' and
      params[:session][:password] == 'bar' then
      cookies[:super_secure_signin_credentials] = SUPER_SESSION_SECRET
      redirect_to appointments_path
    else
      if params[:session][:email] != '' or
        params[:session][:password] != '' then
        redirect_to signin_path, notice: 'Invalid email or password'
      else
        redirect_to signin_path
      end
    end
  end

  def destroy
  end
end
