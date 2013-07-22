class AccountsController < ApplicationController
  def new
    @title = 'Sign Up'
    @account = Account.new
    @user = User.new
  end

  def create
    if create_new_account(get_account_params.merge(active: 1),
                          get_user_params.merge(password_digest: '',
                                           account_administrator: 1,
                                           active: 1))
      # TODO redirect to new user help page that explians all the buttons and gives walk through
      redirect_to @account
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

    def get_account_and_user_params
      params.require(:account).permit(:company_name,
                                      :first_name,
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
          #@user.signin_token = User.new_signin_token
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
