require 'spec_helper'

describe SessionsController do
  it { should respond_to(:new) }
  it { should respond_to(:create) }
  it { should respond_to(:destroy) }
end
