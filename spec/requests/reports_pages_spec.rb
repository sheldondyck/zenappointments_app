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
      within '.signin-dialog' do
        fill_in 'Email', with: 'account@company.com'
        fill_in 'Password', with: 'abcdef'
      end
      click_button 'Log In'
      click_link 'Reports'
      #save_and_open_page
    end

    it 'should have correct path' do
      current_path.should == accounts_reports_path
    end

    describe 'correct html' do
      it { should have_title(app_name + ' | ' + @user.name) }
      it { should have_selector('h1', text: 'Reports') }
      describe 'reports menu' do
        it_behaves_like 'a signedin menu'
        it do
          should_not have_selector('li.active', text: 'Home')
          should_not have_selector('li.active', text: 'Appointments')
          should_not have_selector('li.active', text: 'Clients')
          should_not have_selector('li.active', text: 'Employees')
          should have_selector('li.active', text: 'Reports')
        end
      end
    end
  end
end
