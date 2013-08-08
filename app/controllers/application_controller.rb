class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  around_filter :user_time_zone if :current_user

  private
    def authorize_user
      redirect_to signin_path, notice: 'Access restricted, please sign in' unless signed_in?
    end

    def user_time_zone(&block)
      # TODO: need to define this per user. create field time_zone in database?
      Time.use_zone('Tokyo', &block)
    end
end
