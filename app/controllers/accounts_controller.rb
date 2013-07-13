class AccountsController < ApplicationController

  def new
  end

  def create
    redirect_to login_path
  end
end
