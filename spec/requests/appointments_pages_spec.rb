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

    describe 'correct html' do
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

    describe 'day agenda', js: true do
      before do
        click_link 'Day'
        #  save_and_open_page
      end

      # TODO: get the config for the account for start/end hour and verify that all are shown
      it { should have_selector('td.edit_hour.hour_7') }
      it { should have_selector('td.edit_hour.hour_8') }
      it { should have_selector('td.edit_hour.hour_9') }
      it { should have_selector('td.edit_hour.hour_10') }
      it { should have_selector('td.edit_hour.hour_11') }
      it { should have_selector('td.edit_hour.hour_12') }
      it { should have_selector('td.edit_hour.hour_13') }
      it { should have_selector('td.edit_hour.hour_14') }
      it { should have_selector('td.edit_hour.hour_15') }
      it { should have_selector('td.edit_hour.hour_16') }
      it { should have_selector('td.edit_hour.hour_17') }
      it { should have_selector('td.edit_hour.hour_18') }
      it { should have_selector('td.edit_hour.hour_19') }
      it { should have_selector('h3', Time.zone.now.strftime('%A, %B %e %Y')) }
    end

    describe 'week agenda', js: true do
      before do
        click_link 'Week'
        sleep 0.1
        #save_and_open_page
      end

      it { should_not have_selector('td.edit_hour.hour_12') }
      it { should have_selector('h3', Time.zone.now.strftime('week %V - %Y')) }
      it { should have_selector('h1', 'Week') }
    end

    describe 'month agenda', js: true do
      before do
        click_link 'Month'
        # TODO: find a better way then sleeping
        sleep 0.1
        #save_and_open_page
      end

      it { should_not have_selector('td.edit_hour.hour_12') }
      it { should have_selector('h3', Time.zone.now.strftime('%B %Y')) }
    end

    describe 'year agenda', js: true do
        before do
          click_link 'Year'
          sleep 0.1
          #save_and_open_page
        end

      it { should_not have_selector('td.edit_hour.hour_12') }
      it { should have_selector('h1', 'Year') }
      it { should have_selector('h3', Time.zone.now.strftime('%Y')) }
    end

    describe 'new appointment dialog', js: true do
      describe 'should show dialog' do
        before do
          find('td.edit_hour.hour_14').click
          #  save_and_open_page
        end

        describe 'correct html' do
          it { should have_selector('.new_appointment') }
          it { should have_selector('h4', 'New Appointment') }
          it { should have_field('appointment[first_name]') }
          it { should have_field('appointment[last_name]') }
          it { should have_field('appointment[telephone_cellular]') }
          it { should have_field('appointment[email]') }
          it { should have_button('Save') }
          it { should_not have_selector('.client-appointment') }
        end

        describe 'save appointment' do
          before do
            fill_in 'First Name', with: 'Client Test_Name 1'
            fill_in 'Email', with: 'client_1@client_domain.com'
            click_button 'Save'
            # TODO: find a better way then sleeping
            sleep 0.1
            #puts Capybara.default_wait_time
            #wait_until(Capybara.default_wait_time) do
            #  puts Capybara.default_wait_time
            #  page.evaluate_script 'jQuery.active == 0'
            #end
            #save_and_open_page
          end

          it { should_not have_selector('.new_appointment') }
          it { should have_selector('td.edit_hour.hour_14 .client-appointment', text: 'Client Test_Name 1') }
          it { should_not have_selector('td.edit_hour.hour_15 .client-appointment', text: 'Client Test_Name 1') }
          it { should_not have_selector('.client-appointment', text: 'Client Test_Name 2') }
        end
      end
    end
  end
end
