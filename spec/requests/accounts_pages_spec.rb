require 'spec_helper'

describe 'account pages' do
  ########## signup ##########
  describe 'signup page' do
    describe 'GET /signup' do
      it 'should exist' do
        get signup_path
        response.status.should be(200)
      end
    end

    subject { page }
    before { visit signup_path }

    describe 'html' do
      it { should have_selector('legend', text: 'Sign Up') }
      it { should have_field('account[first_name]') }
      it { should have_field('account[last_name]') }
      it { should have_field('account[company_name]') }
      it { should have_field('account[email]') }
      it { should have_field('account[password]') }
      it { should have_button('Sign Up') }
      it { should have_link('I already have an account. Sign in now!', href: login_path) }
    end

    let(:submit) { 'Sign Up' }

    describe 'with incomplete information' do
      it 'should not create an account' do
        #before { save_and_open_page }
        expect { click_button submit }.not_to change(Account, :count)
      end

      it 'should show a error message' do
        click_button submit
        should have_selector('.alert.alert-error')
      end
    end

    describe 'with valid information' do
      before do
        fill_in 'First Name', with: 'My First'
        fill_in 'Last Name', with: 'My Last'
        fill_in 'Company Name', with: 'My Company'
        fill_in 'Email', with: 'foo@bar.com'
        fill_in 'Password', with: 'foobar'
      end

      it 'should create an account' do
        expect { click_button submit }.to change(Account, :count).by(1)
      end

      it 'should create an user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  ########## show ##########
  # TODO: use X_path and not hardcoded strings
  describe 'show page' do
    describe 'GET /accounts/1' do
      it 'should exist' do
        get '/accounts/1'
        response.status.should be(200)
      end
    end

    subject { page }
    before { visit '/accounts/1' }

    describe 'html' do
      it { should have_selector('h1', text: 'Accounts') }
    end
  end
end
