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
  it { should respond_to(:icon_tag) }
  it { expect(www_url).to eq('http://127.0.0.1:4000') }
  it { expect(icon_tag('exclamation-triangle')).to eq("<i class='fa fa-exclamation-triangle'></i>") }
end

