class UsersController < ApplicationController
  prepend_before_action :authorize_user

  def index
    @title = @current_user.name
  end

  def new
  end

  def create
  end

  def show
    @title = @current_user.name
  end

  def update
  end

  def delete
  end
end
