require 'spec_helper'

describe "UsersPages" do
  describe "GET /users" do
    it 'should redirect' do
      get users_path
      response.status.should be(302)
    end
  end

  #describe "GET /users/1" do
    #it 'should redirect' do
      #get "/users/1"
      #response.status.should be(200)
    #end
  #end
end

