require 'spec_helper'

describe SessionsHelper do
  subject { helper }

  it { should respond_to(:signed_in?) }
  #it { should respond_to(:current_user) }
end
