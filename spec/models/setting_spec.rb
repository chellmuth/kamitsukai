require 'spec_helper'

describe 'A Setting' do
  it 'should be created with a key, and a value' do
    s = Setting.new(Setting.plan)
    s.should be_valid
    s.save.should be_true
  end

  it 'should be invlid without a key, and a value' do
    s = Setting.new
    s.should_not be_valid

    s.key = 'Foo'
    s.should_not be_valid

    s.value = 'Bar'
    s.should be_valid

    s.save.should be_true
  end

  it 'should only be able to be created once for any given key' do
    setting_plan = Setting.plan

    Setting.should have(:no).records

    Setting.create!(setting_plan)
    Setting.should have(1).record

    new_setting = Setting.new(
      :key   => setting_plan[:key],
      :value => setting_plan[:value] + ' duplicate'
    )

    new_setting.should_not be_valid
  end
end
