require 'spec_helper'

describe 'Login Page' do
  subject { page }

  describe "GET /login" do
    it "should exist" do
      get login_path
      response.status.should be(200)
    end
  end

  describe 'html' do
    before {
      visit login_path
      #save_and_open_page
    }

    it { should have_selector('legend', text: 'Welcome back') }
    it { should have_field('session[email]') }
    it { should have_field('session[password]') }
    it { should have_button('Login') }
    it { should have_link('You don\'t have an account? Sign up now!', href: signup_path) }
  end

  describe 'correct login' do
    before {
      visit login_path
      within '.form-signin' do
        fill_in 'session[email]', with: 'foo'
        fill_in 'session[password]', with: 'bar'
      end
      click_button 'Login'
    }

    it 'signs in' do
      current_path.should == appointments_path
    end

    it 'stays signed in' do
      visit appointments_path
      current_path.should == appointments_path
    end

    it 'should not be signed in after deleting cookies' do
      pending 'delete cookies and verify that is not signed in'
    end
  end

  describe 'incorrect login' do
    before {
      visit login_path
      within '.form-signin' do
        fill_in 'session[email]', with: 'foo'
        fill_in 'session[password]', with: 'bar1'
      end
      click_button 'Login'
    }

    it 'does not sign in' do
      current_path.should == login_path
    end

    it 'has correct message' do
      should have_selector('.alert.alert-notice', text: 'Invalid email or password')
    end

    it 'protected pages are still protected' do
      visit appointments_path
      current_path.should == login_path
    end
  end

  describe 'sign up link' do
    before {
      visit login_path
      click_link 'You don\'t have an account? Sign up now!'
    }

    it 'should be correct' do
      current_path.should == signup_path
    end
  end
end
