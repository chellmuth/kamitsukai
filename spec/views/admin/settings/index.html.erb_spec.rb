require 'spec_helper'

describe "/admin/settings/index" do
  it "should tell you where you are" do
    assigns[:settings] = []
    render 'admin/settings/index'

    response.should have_tag('h1', %r[Listing settings])
  end

  describe 'without any existing settings' do
    before(:each) do
      assigns[:settings] = []
      render 'admin/settings/index'
    end

    it 'should have an empty tbody' do
      response.should have_tag('tbody') do
        with_tag('tr', 0)
      end
    end
  end

  describe 'with one existing setting' do
    before(:each) do
      setting = mock_model(Setting)
      setting.should_receive(:key).and_return('foo')
      setting.should_receive(:value).and_return(42)

      assigns[:settings] = [setting]
      render 'admin/settings/index'
    end

    it 'should have a single row in the tbody' do
      response.should have_tag('tbody') do
        with_tag('tr', 1)
      end
    end

    it 'should have the setting values, and links in the row' do
      response.should have_tag('tbody tr') do
        with_tag('td', 'foo')
        with_tag('td', '42')
        with_tag('td', /Show/)
        with_tag('td', /Edit/)
        with_tag('td', /Destroy/)
      end
    end
  end

  describe 'with multiple existing settings' do
    before(:each) do
      setting1 = mock_model(Setting)
      setting1.should_receive(:key).and_return('foo')
      setting1.should_receive(:value).and_return(42)

      setting2 = mock_model(Setting)
      setting2.should_receive(:key).and_return('bar')
      setting2.should_receive(:value).and_return('baz')

      assigns[:settings] = [setting1, setting2]
      render 'admin/settings/index'
    end

    it 'should have multiple rows in the tbody' do
      response.should have_tag('tbody') do
        with_tag('tr', 2)
      end
    end

    it 'should have the setting values, and links in the rows' do
      response.should have_tag('tbody') do
        with_tag('tr') do
          with_tag('td', 'foo')
          with_tag('td', '42')
          with_tag('td', /Show/)
          with_tag('td', /Edit/)
          with_tag('td', /Destroy/)
        end
        with_tag('tr') do
          with_tag('td', 'bar')
          with_tag('td', 'baz')
          with_tag('td', /Show/)
          with_tag('td', /Edit/)
          with_tag('td', /Destroy/)
        end
      end
    end
  end
end
