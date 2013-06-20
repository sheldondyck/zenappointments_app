class SessionsController < ApplicationController
  def new
  end

  def create
    redirect_to appointments_path
  end

  def destroy
  end
end
