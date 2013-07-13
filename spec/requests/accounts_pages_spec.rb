require 'spec_helper'

describe "Account Pages" do
  describe "Signup page" do
    describe "GET /signup" do
      it "should exist" do
        get signup_path
        response.status.should be(200)
      end
    end

    subject { page }

    describe 'html' do
      before {
        visit signup_path
        #save_and_open_page
      }

      it { should have_selector('legend', text: 'Sign Up') }
      it { should have_field('account[first_name]') }
      it { should have_field('account[last_name]') }
      it { should have_field('account[company]') }
      it { should have_field('account[email]') }
      it { should have_field('account[password]') }
      it { should have_button('Sign Up') }
      it { should have_link('I already have an account. Sign in now!', href: signup_path) }
    end
  end
end
