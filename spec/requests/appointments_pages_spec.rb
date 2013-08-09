require 'spec_helper'

describe 'AppointmentsPages' do
  describe 'GET /appointments' do
    it 'should redirect' do
      get appointments_path
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
      #save_and_open_page
    end

    it 'should have correct path' do
      current_path.should == appointments_path
    end

    describe 'html' do
      it { should have_title('ZenAppointments | ' + @user.name) }
      describe 'appointments menu' do
        it_behaves_like 'a signedin menu'
        it { should_not have_selector('li.active', text: 'Home') }
        it { should have_selector('li.active', text: 'Appointments') }
        it { should_not have_selector('li.active', text: 'Clients') }
        it { should_not have_selector('li.active', text: 'Employees') }
        it { should_not have_selector('li.active', text: 'Reports') }
      end
      # TODO: test link of angle-left
      it { should have_selector('i.icon-angle-left') }
      # TODO: test link of angle-right
      it { should have_selector('i.icon-angle-right') }
      it { should have_link('Day', href: appointments_path(view: 'day')) }
      it { should have_link('Week', href: appointments_path(view: 'week')) }
      it { should have_link('Month', href: appointments_path(view: 'month')) }
      it { should have_link('Year', href: appointments_path(view: 'year')) }
    end
  end
end
