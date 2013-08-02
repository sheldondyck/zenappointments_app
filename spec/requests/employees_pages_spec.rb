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

    # TODO this is almost completely duplicated from appointments_pages_spec
    describe 'html' do
      it { should have_title('ZenAppointments | ' + @user.name) }

      describe 'menu' do
        # TODO verify app_name url
        it { should have_link('Home', href: accounts_home_path) }
        it { should_not have_selector('li.active', text: 'Home') }
        it { should have_link('Appointments', href: appointments_path) }
        it { should_not have_selector('li.active', text: 'Appointments') }
        it { should have_link('Clients', href: clients_index_path) }
        it { should_not have_selector('li.active', text: 'Clients') }
        it { should have_link('Employees', href: employees_index_path) }
        it { should have_selector('li.active', text: 'Employees') }
        it { should have_link('Reports', href: accounts_reports_path) }
        it { should_not have_selector('li.active', text: 'Reports') }
        # TODO verify cog link url 
        it { should have_selector('i.icon-cog') }
        # TODO verify signout link url
        it { should have_selector('i.icon-signout') }
        it { should have_link(@user.name, href: user_path(@user)) }
      end
    end
  end
end

