class DashboardController < ApplicationController
  prepend_before_action :authorize_user
  respond_to :json, :html

  def index
    @title = @current_user.name
  end
end
