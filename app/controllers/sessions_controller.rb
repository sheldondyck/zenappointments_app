class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:session][:email] == 'foo' and
      params[:session][:password] == 'bar' then
      cookies[:super_secure_login_credentials] = 'abc123'
      redirect_to appointments_path
    else
      if params[:session][:email] != '' or
        params[:session][:password] != '' then
        redirect_to login_path, notice: 'Invalid email or password'
      else
        redirect_to login_path
      end
    end
  end

  def destroy
  end
end
