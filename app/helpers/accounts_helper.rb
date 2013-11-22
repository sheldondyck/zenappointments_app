module AccountsHelper
  def zen_account_demo_message
    render('accounts/demo_expire_message') if current_user.account.is_demo?
  end
end
