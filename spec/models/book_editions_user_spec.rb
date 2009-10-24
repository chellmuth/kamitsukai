require 'spec_helper'

describe BookEditionsUser do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :book_edition_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    BookEditionsUser.create!(@valid_attributes)
  end
end
