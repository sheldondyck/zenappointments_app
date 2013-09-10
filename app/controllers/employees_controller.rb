class EmployeesController < ApplicationController
  prepend_before_action :authorize_user

  def index
    @title = @current_user.name
  end
end
