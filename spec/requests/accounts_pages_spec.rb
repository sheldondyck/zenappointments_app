require 'spec_helper'
include ApplicationHelper

describe 'account pages' do
  describe 'signup page' do
    describe 'GET /signup' do
      it 'should exist' do
        get '/signup'
        response.status.should be(200)
      end
    end

    subject { page }
    before { visit signup_path }

    describe 'correct html' do
      it { should have_title('Sign Up') }
      it { should have_selector('h1', text: app_name) }
      it { should have_link(app_name, href: www_url) }
      it { should have_selector('legend', text: "Get started with #{app_name} by filling out this simple form") }
      it { should have_field('account[first_name]') }
      it { should have_field('account[last_name]') }
      it { should have_field('account[company_name]') }
      it { should have_field('account[email]') }
      it { should have_field('account[password]') }
      it { should have_button("Create my #{app_name} account!") }
      it { should have_button('Show') }
      it { should have_selector(:xpath, "//button[@class='btn btn-default btn-show-hide-password']", text: "Show") }
      it { should have_selector('p', text: 'I already have an account.') }
      it { should have_link('Log in now!', href: signin_path) }
    end

    let(:submit) { "Create my #{app_name} account!" }

    # TODO specs for show/hide button

    describe 'with valid information' do
      before do
        fill_in 'First Name', with: 'My First'
        fill_in 'Last Name', with: 'My Last'
        fill_in 'Company Name', with: 'My Company'
        fill_in 'Email', with: 'my_email@my_company.com'
        fill_in 'Password', with: 'foobar'
      end

      it 'should create an account' do
        expect { click_button submit }.to change(Account, :count).by(1)
      end

      it 'should create an user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'should signin user' do
        before { click_button submit }
        it { current_path.should == accounts_welcome_path }
        it { should have_title('Welcome')}
        it { should have_selector('h1', 'Welcome')}
        it { should have_link('Start Tutorial')}
        it { should have_link('Skip Tutorial')}

        describe 'should skip tutorial user' do
          before { click_link 'Skip Tutorial' }
          it { current_path.should == appointments_path }
          # TODO is their a better way to test with icons?
          it { should have_selector('i.icon-signout') }

          describe 'should signout user' do
            # TODO is their a better way to test with icons?
            before { find_by_id('link-signout').click }

            it { should have_button('Log In') }

            describe 'should signin user again without tutorial' do
              before do
                within '.signin-dialog' do
                  fill_in 'Email', with: 'my_email@my_company.com'
                  fill_in 'Password', with: 'foobar'
                end
                click_button 'Log In'
              end
              it { current_path.should == appointments_path }
            end
          end
        end

        describe 'should play tutorial' do
          before { click_link 'Start Tutorial' }
          it { current_path.should == accounts_tutorial_path }
        end
      end
    end

    describe 'with incomplete information' do
      it 'should not create an account' do
        #before { save_and_open_page }
        expect { click_button submit }.not_to change(Account, :count)
      end

      it 'should show a general error message' do
        click_button submit
        should have_selector('.alert.alert-danger', text: 'Please fix the problems with the form')
      end

      it 'should show a first_name error message' do
        click_button submit
        #save_and_open_page
        should have_selector('p.help-block#first-name', text: 'Can\'t be blank')
        should have_selector('.form-group.has-error#first-name')
      end

      it 'should show a last_name error message' do
        click_button submit
        should have_selector('p.help-block#last-name', text: 'Can\'t be blank')
        should have_selector('.form-group.has-error#last-name')
      end

      it 'should show a copmany_name error message' do
        click_button submit
        should have_selector('p.help-block#company-name', text: 'Can\'t be blank')
        should have_selector('.form-group.has-error#company-name')
      end

      it 'should show a email error message' do
        click_button submit
        should have_selector('p.help-block#email', text: 'Can\'t be blank')
        should have_selector('.form-group.has-error#email')
      end

      it 'should show a password error message' do
        click_button submit
        should have_selector('p.help-block#password', text: 'Can\'t be blank')
        should have_selector('.form-group.has-error#password')
      end
    end

    describe 'with missing company account information' do
      before do
        fill_in 'First Name', with: 'My First'
        fill_in 'Last Name', with: 'My Last'
        #fill_in 'Company Name', with: 'My Company'
        fill_in 'Email', with: 'my_email@my_company.com'
        fill_in 'Password', with: 'foobar'
      end

      it 'should not create an account' do
        expect { click_button submit }.not_to change(Account, :count)
      end

      it 'should not create an user' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with incomplete information' do
      it 'should return previous value in first_name field' do
        fill_in 'First Name', with: 'My First'
        click_button submit
        should have_field('account[first_name]', with: 'My First')
      end

      it 'should return previous value in last_name field' do
        fill_in 'Last Name', with: 'My Last'
        click_button submit
        should have_field('account[last_name]', with: 'My Last')
      end

      it 'should return previous value in company field' do
        fill_in 'Company Name', with: 'My Company'
        click_button submit
        should have_field('account[company_name]', with: 'My Company')
      end

      it 'should return previous value in email field' do
        fill_in 'Email', with: 'foo@bar.com'
        click_button submit
        should have_field('account[email]', with: 'foo@bar.com')
      end
    end

    describe 'with missing fist name user information' do
      before do
        #fill_in 'First Name', with: 'My First'
        fill_in 'Last Name', with: 'My Last'
        fill_in 'Company Name', with: 'My Company'
        fill_in 'Email', with: 'my_email@my_company.com'
        fill_in 'Password', with: 'foobar'
      end

      it 'should not create an account' do
        expect { click_button submit }.not_to change(Account, :count)
      end

      it 'should not create an user' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with missing last name user information' do
      before do
        fill_in 'First Name', with: 'My First'
        #fill_in 'Last Name', with: 'My Last'
        fill_in 'Company Name', with: 'My Company'
        fill_in 'Email', with: 'my_email@my_company.com'
        fill_in 'Password', with: 'foobar'
      end

      it 'should not create an account' do
        expect { click_button submit }.not_to change(Account, :count)
      end

      it 'should not create an user' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with missing email user information' do
      before do
        fill_in 'First Name', with: 'My First'
        fill_in 'Last Name', with: 'My Last'
        fill_in 'Company Name', with: 'My Company'
        #fill_in 'Email', with: 'my_email@my_company.com'
        fill_in 'Password', with: 'foobar'
      end

      it 'should not create an account' do
        expect { click_button submit }.not_to change(Account, :count)
      end

      it 'should not create an user' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with invalid email user information' do
      before do
        fill_in 'First Name', with: 'My First'
        fill_in 'Last Name', with: 'My Last'
        fill_in 'Company Name', with: 'My Company'
        fill_in 'Email', with: 'foo@.com'
        fill_in 'Password', with: 'foobar'
      end

      it 'should not create an account' do
        expect { click_button submit }.not_to change(Account, :count)
      end

      it 'should not create an user' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with missing password user information' do
      before do
        fill_in 'First Name', with: 'My First'
        fill_in 'Last Name', with: 'My Last'
        fill_in 'Company Name', with: 'My Company'
        fill_in 'Email', with: 'my_email@my_company.com'
        #fill_in 'Password', with: 'foobar'
      end

      it 'should not create an account' do
        expect { click_button submit }.not_to change(Account, :count)
      end

      it 'should not create an user' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with the same account information duplicated' do
      before do
        fill_in 'First Name', with: 'My First'
        fill_in 'Last Name', with: 'My Last'
        fill_in 'Company Name', with: 'My Company'
        fill_in 'Email', with: 'my_email@my_company.com'
        fill_in 'Password', with: 'foobar'

        expect { click_button submit }.to change(Account, :count).by(1)
        visit signup_path

        fill_in 'First Name', with: 'My First'
        fill_in 'Last Name', with: 'My Last'
        fill_in 'Company Name', with: 'My Company'
        fill_in 'Email', with: 'my_email@my_company.com'
        fill_in 'Password', with: 'foobar'
      end

      it 'should not create account' do
        expect { click_button submit }.to_not change(Account, :count)
      end

      it 'should not create user' do
        expect { click_button submit }.to_not change(User, :count)
      end

      it 'should show a email error message' do
        click_button submit
        should have_selector('p.help-block#email', text: 'Has already been taken')
        should have_selector('.form-group.has-error#email')
      end

      it 'should show a company_name error message' do
        click_button submit
        should have_selector('p.help-block#company-name', text: 'Has already been taken')
        should have_selector('.form-group.has-error#company-name')
      end
    end
  end

  describe 'welcome page' do
    describe 'GET /accounts/welcome' do
      it 'should deny' do
        get '/accounts/welecome'
        response.status.should be(302)
      end
    end

    subject { page }
    before { visit '/accounts/welcome' }

    #describe 'correct html' do
    #  it { should have_selector('h1', text: 'Accounts') }
    #end
  end

  describe 'tutorial page' do
    describe 'GET /accounts/tutorial' do
      it 'should deny' do
        get '/accounts/tutorial'
        response.status.should be(302)
      end
    end

    subject { page }
    before { visit '/accounts/tutorial' }

    #describe 'correct html' do
    #  it { should have_selector('h1', text: 'Accounts') }
    #end
  end

  describe 'show page' do
    describe 'GET /accounts/1' do
      it 'should deny' do
        get '/accounts/1'
        response.status.should be(302)
      end
    end

    subject { page }
    before { visit '/accounts/1' }

    #describe 'correct html' do
    #  it { should have_selector('h1', text: 'Accounts') }
    #end
  end
end
