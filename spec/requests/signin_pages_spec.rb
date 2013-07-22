require 'spec_helper'

describe 'Signin Page' do
  subject { page }

  describe "GET /signin" do
    it "should exist" do
      get signin_path
      response.status.should be(200)
    end
  end

  describe 'html' do
    before {
      visit signin_path
      #save_and_open_page
    }

    it { should have_title('Sign In') }
    it { should have_selector('legend', text: 'Welcome back') }
    it { should have_field('session[email]') }
    it { should have_field('session[password]') }
    it { should have_button('Sign In') }
    it { should have_link('You don\'t have an account? Sign up now!', href: signup_path) }
  end

  describe 'correct signin' do
    before {
      @account = Account.new( company_name: 'Company Name',
                             active: 1)
      @user = User.new(first_name: 'First Name',
                     last_name: 'Last Name',
                     email: 'account_1@company.com',
                     password: 'abcdef',
                     account_administrator: 1,
                     active: 1)
      @account.save
      @user.account_id = @account.id
      @user.save
      visit signin_path
      #within '.form-signin' do
        fill_in 'Email', with: 'account_1@company.com'
        fill_in 'Password', with: 'abcdef'
      #end
      #save_and_open_page
      click_button 'Sign In'
      #save_and_open_page
    }

    it 'signs in' do
      current_path.should == appointments_path
    end

    it 'stays signed in' do
      visit appointments_path
      current_path.should == appointments_path
    end

    it 'should not be signed in after deleting cookies' do
      #pending 'delete cookies and verify that is not signed in'
    end
  end

  describe 'incorrect signin' do
    before {
      visit signin_path
      within '.form-signin' do
        fill_in 'session[email]', with: 'foo'
        fill_in 'session[password]', with: 'bar1'
      end
      click_button 'Sign In'
    }

    it 'does not sign in' do
      current_path.should == signin_path
    end

    it 'has correct message' do
      should have_selector('div.alert.alert-error', text: 'Invalid email or password')
    end

    it 'protected pages are still protected' do
      visit appointments_path
      current_path.should == signin_path
    end

    describe "after visiting another page" do
      before { click_link "You don\'t have an account? Sign up now!" }
      it { should_not have_selector('div.alert.alert-error') }
    end
  end

  describe 'sign up link' do
    before {
      visit signin_path
      click_link 'You don\'t have an account? Sign up now!'
    }

    it 'should be correct' do
      current_path.should == signup_path
    end
  end
end
