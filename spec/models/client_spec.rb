# == Schema Information
#
# Table name: clients
#
#  id                 :integer          not null, primary key
#  account_id         :integer          not null
#  first_name         :string(255)      not null
#  last_name          :string(255)
#  birthday           :date
#  email              :string(255)
#  telephone_cellular :string(255)
#  telephone_home     :string(255)
#  telephone_office   :string(255)
#  custom_fields      :hstore
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe Client do
  before do
    @client = build(:client)
  end

  subject { @client }

  it { should be_valid }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:name) }
  it { should respond_to(:birthday) }
  it { should respond_to(:email) }
  it { should respond_to(:telephone_cellular) }
  it { should respond_to(:telephone_home) }
  it { should respond_to(:telephone_office) }

  describe 'first_name' do
    describe 'is valid' do
      before { @client.first_name = 'A' }
      it { should be_valid }
    end

    describe 'is empty' do
      before { @client.first_name = '' }
      it { should_not be_valid }
    end

    describe 'has no valid characters' do
      before { @client.first_name = '     ' }
      it { should_not be_valid }
    end

    describe 'is too long' do
      before { @client.first_name = 'a' * 49 }
      it { should be_valid }
    end

    describe 'is too long' do
      before { @client.first_name = 'a' * 51 }
      it { should_not be_valid }
    end
  end

  describe 'last_name' do
    describe 'is valid' do
      before { @client.last_name = 'A' }
      it { should be_valid }
    end

    describe 'is empty' do
      before { @client.last_name = '' }
      it { should be_valid }
    end

    describe 'has no valid characters' do
      before { @client.last_name = " \t  " }
      it { should be_valid }
    end

    describe 'even if is very long' do
      before { @client.last_name = 'a' * 49 }
      it { should be_valid }
    end

    describe 'is too long' do
      before { @client.last_name = 'a' * 51 }
      it { should_not be_valid }
    end
  end

  describe 'name' do
    subject { @client.name }

    describe 'is correct' do
      it { should == 'First Name Last Name' }
    end

    describe 'is incorrect' do
      it { should_not == 'Name Last Name' }
    end
  end

  describe 'email' do
    describe 'is empty' do
      before { @client.email = '' }
      it { should_not be_valid }
    end

    describe 'even if is very long' do
      before { @client.email = 'a' * 80 + '@example.com' }
      it { should be_valid }
    end

    describe 'is too long' do
      before { @client.email = 'a' * 101 + '@example.com' }
      it { should_not be_valid }
    end

    describe 'valid format' do
      it 'should be valid' do
        valid_addresses = %w[client@example.com s@a.br client.name@foo.com.br client-name@foo.com user_name@foo.bar.com.br moo-foo@boo.com client+name@foo.br my_email@my_company.com]
        valid_addresses.each do |valid_address|
          @client.email = valid_address
          @client.should be_valid
        end
      end
    end

    describe 'invalid format' do
      it 'should be invalid' do
        invalid_addresses = %w[client@example,com @a.br client%name@foo.com.br user_name@foo client@]
        invalid_addresses.each do |invalid_address|
          @client.email = invalid_address
          @client.should_not be_valid
        end
      end
    end

    describe 'is normalized to lower case' do
      subject { @client.email }
      before do
        @client.email = @client.email.upcase
        @client.save
        pp @client
        @client.email = @client.email.downcase
        @normalized_client = Client.find_by(email: @client.email)
        # TODO db connection problem? does see the id
        pp Client.find(@client.id)
        pp Client.all
        pp @normalized_client
      end
      it 'should be valid' do
        should == @normalized_client.email
      end
    end

    describe 'duplicated is not valid' do
      before do
        user_with_same_email = @client.dup
        user_with_same_email.save
      end
      it { should_not be_valid }
    end

    describe 'duplicated with different case is not valid' do
      before do
        user_with_same_email = @client.dup
        user_with_same_email.email = @client.email.upcase
        user_with_same_email.save
      end
      it { should_not be_valid }
    end
  end

end
