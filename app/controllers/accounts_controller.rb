class AccountsController < ApplicationController
  def new
    @title = 'Sign Up'
    @account = Account.new
    @user = User.new
  end

  def create
    if create_new_account(get_account_params.merge(active: true),
                          get_user_params.merge(account_administrator: true, active: true))
      sign_in @user
      redirect_to accounts_welcome_path
    else
      flash.now[:error] = 'Please fix the problems with the form'
      render 'new'
    end
  end

  def show
  end

  def update
  end

  def delete
  end

  def welcome
    @title = 'Welcome ' + current_user.name
  end

  def tutorial
  end

  private
    def get_account_params
      params.require(:account).permit(:company_name)
    end

    def get_user_params
      params.require(:account).permit(:first_name,
                                      :last_name,
                                      :email,
                                      :password)
    end

    def create_new_account(account_params, user_params)
      # TODO general problem here.  find out how two tables can be modeled in one controller

      begin
        ActiveRecord::Base.transaction do
          @account = Account.new(get_account_params.merge(active: 1))
          @account.save!
          @user = User.new(user_params.merge(account_id: @account.id))
          @user.save!

          return true
        end

      rescue
        if @user.nil?
          @user = User.new(user_params.merge(account_id: @account.id))
          @user.valid?
        end

        return false
      end
    end
end
