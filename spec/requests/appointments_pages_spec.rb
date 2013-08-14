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
        it do
          should_not have_selector('li.active', text: 'Home')
          should have_selector('li.active', text: 'Appointments')
          should_not have_selector('li.active', text: 'Clients')
          should_not have_selector('li.active', text: 'Employees')
          should_not have_selector('li.active', text: 'Reports')
        end
      end

      it do
        # TODO: test link of angle-left
        should have_selector('i.icon-angle-left')
        # TODO: test link of angle-right
        should have_selector('i.icon-angle-right')
        should have_link('Day', href: appointments_path(view: 'day'))
        should have_link('Week', href: appointments_path(view: 'week'))
        should have_link('Month', href: appointments_path(view: 'month'))
        should have_link('Year', href: appointments_path(view: 'year'))
      end
    end

    describe 'day agenda', js: true do
      before do
        click_link 'Day'
        #  save_and_open_page
      end

      # TODO: get the config for the account for start/end hour and verify that all are shown
      it do
        should have_selector('td.edit-hour.hour-7')
        should have_selector('td.edit-hour.hour-8')
        should have_selector('td.edit-hour.hour-9')
        should have_selector('td.edit-hour.hour-10')
        should have_selector('td.edit-hour.hour-11')
        should have_selector('td.edit-hour.hour-12')
        should have_selector('td.edit-hour.hour-13')
        should have_selector('td.edit-hour.hour-14')
        should have_selector('td.edit-hour.hour-15')
        should have_selector('td.edit-hour.hour-16')
        should have_selector('td.edit-hour.hour-17')
        should have_selector('td.edit-hour.hour-18')
        should have_selector('td.edit-hour.hour-19')
        should have_selector('h3', Time.zone.now.strftime('%A, %B %e %Y'))
      end
    end

    describe 'week agenda', js: true do
      before do
        click_link 'Week'
        sleep 0.1
        #save_and_open_page
      end

      it do
        should_not have_selector('td.edit-hour.hour-12')
        should have_selector('h3', Time.zone.now.strftime('week %V - %Y'))
        should have_selector('h1', 'Week')
      end
    end

    describe 'month agenda', js: true do
      before do
        click_link 'Month'
        # TODO: find a better way then sleeping
        sleep 0.1
        #save_and_open_page
      end

      it do
        should_not have_selector('td.edit-hour.hour-12')
        should have_selector('h3', Time.zone.now.strftime('%B %Y'))
      end
    end

    describe 'year agenda', js: true do
      before do
        click_link 'Year'
        sleep 0.1
        #save_and_open_page
      end

      it do
        should_not have_selector('td.edit-hour.hour-12')
        should have_selector('h1', 'Year')
        should have_selector('h3', Time.zone.now.strftime('%Y'))
      end
    end

    describe 'new appointment dialog', js: true do
      describe 'should show dialog' do
        before do
          find('td.edit-hour.hour-14').click
          #  save_and_open_page
        end

        describe 'correct html' do
          it do
            should have_selector('.new-appointment')
            should have_selector('h4', 'New Appointment')
            should have_field('appointment[first_name]')
            should have_field('appointment[last_name]')
            should have_field('appointment[telephone_cellular]')
            should have_field('appointment[email]')
            should have_button('Save')
            should_not have_selector('.client-appointment')
          end
        end

        describe 'save appointment' do
          before do
            fill_in 'First Name', with: 'Client Test_Name 1'
            fill_in 'Email', with: 'client_1@client_domain.com'
            click_button 'Save'
            # TODO: find a better way then sleeping
            sleep 0.2
            #puts Capybara.default_wait_time
            #wait_until(Capybara.default_wait_time) do
            #  puts Capybara.default_wait_time
            #  page.evaluate_script 'jQuery.active == 0'
            #end
            #save_and_open_page
          end

          it do
            should_not have_selector('.new-appointment')
            should have_selector('td.edit-hour.hour-14 .client-appointment', text: 'Client Test_Name 1')
            should_not have_selector('td.edit-hour.hour-15 .client-appointment', text: 'Client Test_Name 1')
            should_not have_selector('.client-appointment', text: 'Client Test_Name 2')
          end
#          describe 'verify appointment', js: true do
#            before do
#              #save_and_open_page
#              click_link 'Day'
#              sleep 0.2
#              #save_and_open_page
#            end

#            it { should have_selector('td.edit-hour.hour-14 .client-appointment', text: 'Client Test_Name 1') }
#          end
        end
      end
    end

#    describe 'with valid appointment data', js: true do
#      before do
#        find('td.edit-hour.hour-14').click
#        sleep 0.5
#        fill_in 'First Name', with: 'Client Test_Name 1'
#        fill_in 'Email', with: 'client_1@client_domain.com'
#        save_and_open_page
#      end
#      it 'should create an appointment' do
#        expect { click_button 'Save' }.to change(Appointment, :count).by(1)
#      end
#    end
  end
end
