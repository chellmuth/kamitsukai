require 'spec_helper'

describe "/admin/settings/edit" do
  before(:each) do
    setting = mock_model(Setting)
    setting.should_receive(:key).and_return('foo')
    setting.should_receive(:value).and_return(42)
    assigns[:setting] = setting
    render 'admin/settings/edit'
  end

  it "should tell you where you are" do
    response.should have_tag('h1', %r[Editing setting])
  end

  it 'should populate the key text box' do
    response.should have_tag('input[name=?][value=?]', 'setting[key]', 'foo')
  end

  it 'should populate the value text box' do
    response.should have_tag('input[name=?][value=?]', 'setting[value]', '42')
  end
end
