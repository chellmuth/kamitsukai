require 'spec_helper'

describe 'An AmazonImage' do
  it 'should create a new instance given valid attributes' do
    image = AmazonImage.new(AmazonImage.plan)
    image.should be_valid
    image.save.should be_true
  end

  it 'should not be valid without a url' do
    image = AmazonImage.new(AmazonImage.plan(:url => nil))
    image.should_not be_valid

    image.url = 'http://example.com'
    image.should be_valid

    image.save.should be_true
  end

  it 'should not be valid without a height' do
    image = AmazonImage.new(AmazonImage.plan(:height => nil))
    image.should_not be_valid

    image.height = 10
    image.should be_valid

    image.save.should be_true
  end

  it 'should not be valid without height_units' do
    image = AmazonImage.new(AmazonImage.plan(:height_units => nil))
    image.should_not be_valid

    image.height_units = 'px'
    image.should be_valid

    image.save.should be_true
  end

  it 'should not be valid without a width' do
    image = AmazonImage.new(AmazonImage.plan(:width => nil))
    image.should_not be_valid

    image.width = 10
    image.should be_valid

    image.save.should be_true
  end

  it 'should not be valid without width_units' do
    image = AmazonImage.new(AmazonImage.plan(:width_units => nil))
    image.should_not be_valid

    image.width_units = 'px'
    image.should be_valid

    image.save.should be_true
  end

  it 'should be able to be associated with book_editions' do
    image = AmazonImage.make
    editions = [
      BookEdition.make,
      BookEdition.make,
      BookEdition.make
    ]

    image.should have(:no).book_editions

    image.book_editions << editions[0]
    image.reload

    image.should have(1).book_edition
    image.book_editions.should     include(editions[0])
    image.book_editions.should_not include(editions[1])
    image.book_editions.should_not include(editions[2])

    image.book_editions << editions[1]
    image.reload

    image.should have(2).book_editions
    image.book_editions.should     include(editions[0])
    image.book_editions.should     include(editions[1])
    image.book_editions.should_not include(editions[2])

    image.book_editions << editions[2]
    image.reload

    image.should have(3).book_editions
    image.book_editions.should include(editions[0])
    image.book_editions.should include(editions[1])
    image.book_editions.should include(editions[2])
  end
end
