require 'spec_helper'

describe AccountsController do
  it { should respond_to(:new) }
  it { should respond_to(:create) }
  it { should respond_to(:show) }
  it { should respond_to(:update) }
  it { should respond_to(:delete) }
  it { should respond_to(:welcome) }
  it { should respond_to(:tutorial) }

  # TODO create account/user should have user as adminstrator
end
