require 'spec_helper'
include ApplicationHelper

shared_examples 'a signedin menu' do
  describe 'menu' do
    it do
      should have_link(app_name, href: www_url)
      should have_link('Home', href: accounts_home_path)
      should have_link('Appointments', href: appointments_path)
      should have_link('Clients', href: clients_path)
      should have_link('Employees', href: employees_index_path)
      should have_link('Reports', href: accounts_reports_path)
      # TODO verify cog link url
      should have_selector('i.fa.fa-cog')
      # TODO verify signout link url
      should have_selector('i.fa.fa-sign-out')
      should have_link(@user.name, href: user_path(@user))
    end
  end
end
