require 'spec_helper'

describe "UsersPages" do
  describe "GET /users" do
    it 'should redirect' do
      get users_path
      response.status.should be(302)
    end
  end
end
