class AccountsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params.merge(active: 1))
    if @account.save
      @user = User.new(user_params.merge(account_id: @account.id,
                                         password_digest: '',
                                         account_administrator: 1,
                                         active: 1))
      # TODO should be in a transaction with account so rollback undoes everything
      if @user.save
        # TODO redirect to new user help page that explians all the buttons and gives walk through
        redirect_to @account
      else
        flash.now[:error] = "Please fix the problems with the form"
        render 'new'
      end
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
    def account_params
      params.require(:account).permit(:company_name)
    end

    def user_params
      params.require(:account).permit(:first_name,
                                      :last_name,
                                      :email,
                                      :password)
    end
end
