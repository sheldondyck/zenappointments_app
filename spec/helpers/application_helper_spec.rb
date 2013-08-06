require 'spec_helper'

describe ApplicationHelper do
  subject { helper }

  it { should respond_to(:app_name) }
  it { should respond_to(:title) }
  it { should respond_to(:flash_handler) }
  it { should respond_to(:menu_link_icon_to) }
  it { should respond_to(:link_icon_to) }
  it { should respond_to(:remote_link_icon_to) }
  it { should respond_to(:error_class) }
  it { should respond_to(:error_message) }
  it { should respond_to(:www_url) }
end

