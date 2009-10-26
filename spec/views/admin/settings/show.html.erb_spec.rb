require 'spec_helper'

describe "/admin/settings/show" do
  before(:each) do
    setting = mock_model(Setting)
    setting.should_receive(:key).and_return('foo')
    setting.should_receive(:value).and_return(42)
    assigns[:setting] = setting
    render 'admin/settings/show'
  end

  it "should show the setting key and value" do
    response.should have_tag('p', %r[foo: 42])
  end
end
