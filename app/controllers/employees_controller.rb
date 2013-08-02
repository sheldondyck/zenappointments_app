class EmployeesController < ApplicationController
  before_action :authorize_user

  def index
    @title = @current_user.name
  end
end
