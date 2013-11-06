require 'spec_helper'

describe AccountsController do
  it { should_not respond_to(:index) }
  it { should respond_to(:new) }
  it { should respond_to(:create) }
  it { should respond_to(:show) }
  it { should respond_to(:update) }
  it { should respond_to(:delete) }
  it { should respond_to(:welcome) }
  it { should respond_to(:tutorial) }
  it { should respond_to(:home) }
  it { should respond_to(:reports) }
  it { should respond_to(:payments) }
  #TODO: write specs for multi-tenant
end
