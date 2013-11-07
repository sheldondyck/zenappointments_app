class ClientsController < ApplicationController
  prepend_before_action :authorize_user
  respond_to :json, :html

  def index
    #puts 'CLIENT INDEX'
    @title = @current_user.name
    #respond_with Client.all
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
    puts 'search: ' + params[:term]
    # TODO: what is best way to not do the search if :term == "" ?
    @clients = Array.new
    # TODO: why is this scope not lazy loaded? should only execute at db on view render,
    # but in the console is executing imediately.
    @clients = Client.search_name(params[:term], 10).to_a unless params[:term].empty?
    #pp @clients
    #puts 'first_name:' + @clients.first.first_name unless @clients.size == 0
  end
end
