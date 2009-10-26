require 'spec_helper'

describe "/admin/settings/new" do
  before(:each) do
    setting = mock_model(Setting)
    setting.should_receive(:key).and_return(nil)
    setting.should_receive(:value).and_return(nil)
    assigns[:setting] = setting
    render 'admin/settings/new'
  end

  it "should tell you that you are editing a new setting" do
    response.should have_tag('h1', %r[New setting])
  end

  it 'should not have anything in the key text box' do
    response.should have_tag('input[name=?]', 'setting[key]')
    response.should_not have_tag('input[name=?][value]', 'setting[key]')
  end

  it 'should not have anything in the value text box' do
    response.should have_tag('input[name=?]', 'setting[value]')
    response.should_not have_tag('input[name=?][value]', 'setting[value]')
  end
end
