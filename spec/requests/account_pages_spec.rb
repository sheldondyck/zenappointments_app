require 'spec_helper'

describe "Account Pages" do
  subject { page }

  describe "create account" do
    before {
      visit signup_path
      #save_and_open_page
    }

    it { should have_selector('h1', text: 'Sign Up') }
  end
end
