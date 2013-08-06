require 'spec_helper'
include ApplicationHelper

describe 'reports pages' do
  describe 'GET /accounts/reports' do
    it 'should deny' do
      get '/accounts/reports'
      response.status.should be(302)
    end
  end

  describe 'signin and basic usage' do
    subject { page }

    before do
      @user = create(:user)
      visit signin_path
      within '.form-signin' do
        fill_in 'Email', with: 'account@company.com'
        fill_in 'Password', with: 'abcdef'
      end
      click_button 'Sign In'
      click_link 'Reports'
      #save_and_open_page
    end

    it 'should have correct path' do
      current_path.should == accounts_reports_path
    end

    describe 'html' do
      it { should have_title('ZenAppointments | ' + @user.name) }
      it { should have_selector('h1', text: 'Reports') }
      it_behaves_like 'a signedin menu'
      describe 'reports menu' do
        it { should_not have_selector('li.active', text: 'Home') }
        it { should_not have_selector('li.active', text: 'Appointments') }
        it { should_not have_selector('li.active', text: 'Clients') }
        it { should_not have_selector('li.active', text: 'Employees') }
        it { should have_selector('li.active', text: 'Reports') }
      end
    end
  end
end
