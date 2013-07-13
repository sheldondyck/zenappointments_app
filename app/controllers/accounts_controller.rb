class AccountsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    active_params = account_params
    active_params[:active] = 1
    @account = Account.new(active_params)
    if @account.save
      redirect_to @account
    else
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
      params.require(:account).permit(:first_name,
                                      :last_name,
                                      :company_name,
                                      :email,
                                      :password)
    end
end
