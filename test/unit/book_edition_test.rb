require 'test_helper'

class BookEditionTest < ActiveSupport::TestCase
  test "create valid book edition" do
    e = BookEdition.new(
      :book => Book.make
    )
    assert e.valid?
  end

  test "create book edition without associated book" do
    e = BookEdition.new
    assert !e.valid?
  end
end
