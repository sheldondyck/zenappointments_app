module AccountsHelper
  def zen_account_demo_message
    render('accounts/demo_expire_message') if Account.is_demo?
  end
end
