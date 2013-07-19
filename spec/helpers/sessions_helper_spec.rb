require 'spec_helper'

describe SessionsHelper do
  subject { helper }

  it { should respond_to(:signed_in?) }
end
