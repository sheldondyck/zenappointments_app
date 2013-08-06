require 'spec_helper'

describe "Employees Page" do
  describe "GET /employees/index" do
    it 'should redirect' do
      get clients_index_path
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
      click_link 'Employees'
      #save_and_open_page
    end

    it 'should have correct path' do
      current_path.should == employees_index_path
    end

    describe 'html' do
      it { should have_title('ZenAppointments | ' + @user.name) }
      it { should have_selector('h1', text: 'Employees') }
      it_behaves_like 'a signedin menu'
      describe 'employees menu' do
        it { should_not have_selector('li.active', text: 'Home') }
        it { should_not have_selector('li.active', text: 'Appointments') }
        it { should_not have_selector('li.active', text: 'Clients') }
        it { should have_selector('li.active', text: 'Employees') }
        it { should_not have_selector('li.active', text: 'Reports') }
      end
    end
  end
end

