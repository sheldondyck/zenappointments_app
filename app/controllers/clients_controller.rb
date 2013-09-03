class ClientsController < ApplicationController
  before_action :authorize_user
  respond_to :json, :html

  def index
    #puts 'CLIENT INDEX'
    @title = @current_user.name
    respond_with Client.all
  end

  def show
    respond_with Client.find(params[:id])
  end

  def create
    #respond_with Client.create(params[:id])
  end

  def update
  end

  def destroy
  end

  def search
  end
end
