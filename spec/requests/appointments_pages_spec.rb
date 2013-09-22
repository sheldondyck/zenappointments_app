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
      within '.signin-dialog' do
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
        # TODO: does not have .edit-hour
        #should have_selector('td.edit-hour.hour-7')
        should have_selector(:xpath, '//td[@data-hour="7"]')
        should have_selector(:xpath, '//td[@data-hour="8"]')
        should have_selector(:xpath, '//td[@data-hour="9"]')
        should have_selector(:xpath, '//td[@data-hour="10"]')
        should have_selector(:xpath, '//td[@data-hour="11"]')
        should have_selector(:xpath, '//td[@data-hour="12"]')
        should have_selector(:xpath, '//td[@data-hour="13"]')
        should have_selector(:xpath, '//td[@data-hour="14"]')
        should have_selector(:xpath, '//td[@data-hour="15"]')
        should have_selector(:xpath, '//td[@data-hour="16"]')
        should have_selector(:xpath, '//td[@data-hour="17"]')
        should have_selector(:xpath, '//td[@data-hour="18"]')
        should have_selector(:xpath, '//td[@data-hour="19"]')
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
        should have_selector('td.edit-hour.hour-12')
        should have_selector('h3', Time.zone.now.strftime('week %V - %Y'))
        #should have_selector('h1', 'Week')
      end
    end

    describe 'month agenda', js: true do
      before do
        click_link 'Month'
        # TODO: find a better way then sleeping
        sleep 0.2
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

    # TODO: verify search dialog html
    # TODO: verify details dialog html

    describe 'create client appointment dialog', js: true do
      describe 'should show dialog' do
        before do
          find(:xpath, '//td[@data-hour="3"]').click
          # TODO need to get timezone from config. for now we are using Tokyo to find assumptions
          Time.zone = 'Tokyo'
          click_button 'Add'
          #save_and_open_page
        end

        describe 'correct html' do
          it do
            should have_selector('.appointment-dialog')
            should have_selector('.appointment-weekday', text: Time.zone.now.strftime('%A'))
            should have_selector('.appointment-date', text: Time.zone.now.strftime('%B %e %Y'))
            should have_selector('.appointment-time', text: '3:00 - 4:00')
            should have_selector('.appointment-duration', text: '60 mins')
            should have_selector('h4', 'Appointment')
            should have_field('appointment[first_name]')
            should have_field('appointment[last_name]')
            should have_field('appointment[telephone_cellular]')
            should have_field('appointment[email]')
            should have_button('Add')
            should_not have_selector('.client-appointment')
          end
        end

        describe 'save appointment', js: true do
          before do
            fill_in 'appointment[first_name]', with: 'Client Test_Name 1'
            fill_in 'appointment[email]', with: 'client_1@client_domain.com'
            #save_and_open_page
            click_button 'Add'
            # TODO: find a better way then sleeping
            sleep 0.5
            #puts Capybara.default_wait_time
            #wait_until(Capybara.default_wait_time) do
            #  puts Capybara.default_wait_time
            #  page.evaluate_script 'jQuery.active == 0'
            #end
            #save_and_open_page
          end

          it do
            #should_not have_selector('.appointment-dialog')
            should have_xpath("//td[@data-hour='3']/div[@class='client-appointment']", text: 'Client Test_Name 1')
            should_not have_selector("//td[@data-hour='4'] .client-appointment", text: 'Client Test_Name 1')
            should_not have_selector('.client-appointment', text: 'Client Test_Name 2')
          end

          describe 'verify appointment', js: true do
            before do
              #save_and_open_page
              click_link 'Day'
              sleep 0.2
              #save_and_open_page
            end

            #it 'shoud stay the same' do
            #  expect { click_link 'Day' }.to change(Appointment, :count).by(0)
            #end
            #it { should have_selector('td.edit-hour.hour-0.client-appointment', text: 'Client Test_Name 1') }
          end

          describe 'drag and drop' do
            before do
              appointment = find('.client-appointment')
              destination = find(:xpath, '//td[@data-hour="5"]')
              #save_and_open_page
              appointment.drag_to(destination)
              sleep 0.5
              #save_and_open_page
            end

            describe 'update appoinment on screen' do
              # TODO: need to update DOM in move.js.haml
              it do
                #should_not have_selector('td.edit-hour.hour-0 .client-appointment', text: 'Client Test_Name 1')
                should have_selector('//td[@data-hour="5" and @class="client-appointment"]', text: 'Client Test_Name 1')
              end
            end

            #describe 'update appoinment in database' do
            #  before do
            #    click_link 'Day'
            #  end

            #  it do
            #    should_not have_selector('td.edit-hour.hour-0 .client-appointment', text: 'Client Test_Name 1')
            #    should have_selector('td.edit-hour.hour-1 .client-appointment', text: 'Client Test_Name 1')
            #  end
            #end
          end
        end
      end
    end

#    describe 'with valid appointment data', js: true do
#      before do
#        find('td.edit-hour.hour-14').click
#        sleep 0.5
#        fill_in 'First Name', with: 'Client Test_Name 1'
#        fill_in 'Email', with: 'client_1@client_domain.com'
#        #save_and_open_page
#      end
#      it 'should create an appointment' do
#        expect { click_button 'Create' }.to change(Appointment, :count).by(1)
#      end
#    end
  end

#  describe 'drag and drop existing appointment' do
#    subject { page }
#
#    before do
#      # TODO don't sign in through webpage. create signin session to save execution time
#      @appointment = create(:appointment)
#      visit signin_path
#      within '.signin-dialog' do
#        fill_in 'Email', with: 'account@company.com'
#        fill_in 'Password', with: 'abcdef'
#      end
#      click_button 'Sign In'
#      #visit appointments_path(date: @appointment.time)
#      #save_and_open_page
#    end

#    it 'should update the appointment' do
#        expect { click_button 'Create' }.to change(Appointment, :count).by(1)
#      should have_selector('td.edit-hour.hour-10 .client-appointment', text: 'Client Test_Name 1')
#      appointment = find('.client-appointment')
#      destination = find('td.edit-hour.hour-15')
#      appointment.drag_to(destination)
#    end
#  end
end
