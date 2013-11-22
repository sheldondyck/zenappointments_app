require 'spec_helper'
include ApplicationHelper

describe 'dashboard pages' do
  describe 'GET /dashboard' do
    it 'should deny' do
      get '/dashboard'
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
      click_button 'Sign In'
      click_link 'Dashboard'
      #save_and_open_page
    end

    it 'should have correct path' do
      current_path.should == dashboard_path
    end

    describe 'correct html' do
      it { should have_title(app_name + ' | ' + @user.name) }
      it { should have_selector('h4', text: 'Activity') }
      it { should have_selector('h4', text: 'Profit') }
      it { should have_selector('h4', text: 'Revenue') }
      describe 'Dashboard menu' do
        it_behaves_like 'a signedin menu'
        it do
          should have_selector('li.active', text: 'Dashboard')
          should_not have_selector('li.active', text: 'Appointments')
          should_not have_selector('li.active', text: 'Clients')
          should_not have_selector('li.active', text: 'Employees')
          should_not have_selector('li.active', text: 'Reports')
        end
      end
    end
  end
end
