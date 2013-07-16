class AccountsController < ApplicationController
  def new
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
      flash.now[:error] = "Please fix the problems with the form"
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

    def create_new_account(account_params, user_params)
      # TODO should be in a transaction with account so rollback undoes everything
      # TODO create test with valid account but invalid user data and test that account is rolled back
      @account = Account.new(get_account_params.merge(active: 1))
      if @account.save
        @user = User.new(user_params.merge(account_id: @account.id))
        if @user.save
          return true
        end
      else
        # TODO saving here to generate error messages. pretty ugly
        @user = User.new
        @user.save
      end
      return false
    end
end
