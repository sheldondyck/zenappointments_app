require 'spec_helper'
include ApplicationHelper

shared_examples 'a signedin menu' do
  describe 'menu' do
    it { should have_link('ZenAppointments', href: www_url) }
    it { should have_link('Home', href: accounts_home_path) }
    it { should have_link('Appointments', href: appointments_path) }
    it { should have_link('Clients', href: clients_index_path) }
    it { should have_link('Employees', href: employees_index_path) }
    it { should have_link('Reports', href: accounts_reports_path) }
    # TODO verify cog link url
    it { should have_selector('i.icon-cog') }
    # TODO verify signout link url
    it { should have_selector('i.icon-signout') }
    it { should have_link(@user.name, href: user_path(@user)) }
  end
end
