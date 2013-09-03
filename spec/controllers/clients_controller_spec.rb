require 'spec_helper'

describe ClientsController do
  it { should respond_to(:index) }
  it { should respond_to(:show) }
  it { should respond_to(:create) }
  it { should respond_to(:update) }
  it { should respond_to(:destroy) }
  it { should respond_to(:search) }
end
