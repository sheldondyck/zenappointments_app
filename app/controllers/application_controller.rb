class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionsHelper

  around_filter :user_time_zone if :current_user
  before_action :scope_current_account
  after_action :unscope_current_account

  private
    def authorize_user
      redirect_to signin_path, alert: 'Access restricted, please log in' unless signed_in?
    end

    def user_time_zone(&block)
      # TODO: need to define this per user. create field time_zone in database?
      Time.use_zone('Tokyo', &block)
    end

    def scope_current_account
      Account.current_id = @current_user.account_id unless @current_user.nil?
    end

    def unscope_current_account
      Account.current_id = nil
    end
end
