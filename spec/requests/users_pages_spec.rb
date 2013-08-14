require 'spec_helper'

describe "UsersPages" do
  describe "GET /users" do
    it 'should redirect' do
      get users_path
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
      click_link @user.name
      #save_and_open_page
    end

    it 'should have correct path' do
      current_path.should == user_path(@user)
    end

    describe 'html' do
      it { should have_title('ZenAppointments | ' + @user.name) }
      it { should have_selector('h1', text: 'User Config') }
      describe 'user menu' do
        it_behaves_like 'a signedin menu'
        it do
          should_not have_selector('li.active', text: 'Home')
          should_not have_selector('li.active', text: 'Appointments')
          should_not have_selector('li.active', text: 'Clients')
          should_not have_selector('li.active', text: 'Employees')
          should_not have_selector('li.active', text: 'Reports')
        end
      end
    end
  end
end

