require 'spec_helper'

describe "Login Pages" do
  subject { page }

  describe "create account" do
    before {
      visit login_path
      #save_and_open_page
    }

    it { should have_selector('legend', text: 'Welcome back') }
    it { should have_selector('input#inputIcon') } #session[email]') }
    it { should have_link('You don\'t have an account? Sign up now!', href: signup_path) }
  end
end
