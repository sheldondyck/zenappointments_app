require 'spec_helper'
include ApplicationHelper

describe 'Signin Page' do
  subject { page }

  describe 'GET /signin' do
    it 'should exist' do
      get signin_path
      response.status.should be(200)
    end
  end

  describe 'correct html' do
    before {
      visit signin_path
      #save_and_open_page
    }

    it { should have_title('Sign In') }
    it { should have_selector('h1', text: 'ZenAppointments') }
    it { should have_link('ZenAppointments', href: www_url) }
    it { should have_selector('legend', text: 'Welcome back') }
    it { should have_field('session[email]') }
    it { should have_field('session[password]') }
    it { should have_button('Sign In') }
    it { should have_selector('p', text: 'You don\'t have an account?') }
    it { should have_link('Sign up now!', href: signup_path) }
  end

  describe 'correct signin' do
    before do
      @user = create(:user)
      visit signin_path
      within '.signin-dialog' do
        fill_in 'Email', with: 'account@company.com'
        fill_in 'Password', with: 'abcdef'
      end
      #save_and_open_page
      click_button 'Sign In'
      #save_and_open_page
    end

    it 'signs in' do
      current_path.should == appointments_path
    end

    describe 'has correct html' do
      # TODO:
      #it { should have_link('.icon-signout', href: signout_path) }
      it { should have_selector('i.icon-signout') }
      it { should have_text(@user.name) }
      it { should have_link(@user.name, href: user_path(@user)) }
    end

    it 'stays signed in' do
      visit appointments_path
      current_path.should == appointments_path
    end

    it 'should not be signed in after deleting cookies' do
      #pending 'delete cookies and verify that is not signed in'
    end

    describe 'it should signout' do
      before { find_by_id('link-signout').click }
      it { should have_button 'Sign In' }
      it { current_path.should == '/' }
    end
  end

  describe 'incorrect signin' do
    before do
      visit signin_path
      within '.signin-dialog' do
        fill_in 'session[email]', with: 'foo@bar.com'
        fill_in 'session[password]', with: 'bar1'
      end
      click_button 'Sign In'
    end

    it 'does not sign in' do
      current_path.should == signin_path
    end

    it 'has correct message' do
      should have_selector('div.alert.alert-danger', text: 'Invalid email or password')
    end

    it 'fills out email' do
      should have_field('session[email]', with: 'foo@bar.com')
    end

    it 'protected pages are still protected' do
      visit appointments_path
      current_path.should == signin_path
    end

    describe 'after visiting another page' do
      before { click_link 'Sign up now!' }
      it { should_not have_selector('div.alert.alert-danger') }
    end
  end

  describe 'sign up link' do
    before do
      visit signin_path
      click_link 'Sign up now!'
    end

    it 'should be correct' do
      current_path.should == signup_path
    end
  end

  describe 'visiting protected page without signin' do
    before do
      visit appointments_path
    end

    it 'should redirect to signin' do
      current_path.should == signin_path
    end

    it 'should have alert message' do
      should have_selector('div.alert.alert-danger', text: 'Access restricted, please sign in')
    end
  end
end
