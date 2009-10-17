require 'amazon/ecs'

class AmazonProductAdvertising
  attr_reader :error, :aws_key, :aws_secret

  def initialize
    @error      = nil
    @aws_key    = _retrieve_aws_key
    @aws_secret = _retrieve_aws_secret

    Amazon::Ecs.options = {
      :aWS_access_key_id => @aws_key,
      :aWS_secret_key    => @aws_secret
    }
  end

  def lookup_book_edition_by_isbn(isbn)
    book = _lookup_book_edition_by(isbn, 'ISBN')
  end

  def lookup_book_edition_by_upc(upc)
    book = _lookup_book_edition_by(upc, 'UPC')
  end

  def has_error?
    @error.nil? ? false : true
  end

  private

  def _lookup_book_edition_by(id, type)
    res = _lookup(:id => id, :id_type => type, :search_index => 'Books')

    if res.has_error?
      @error = res.error
      return nil
    end

    first_item = res.first_item
    item = {}
    item[:asin]            = first_item.get('asin')
    item[:detail_page_url] = first_item.get('detailpageurl')
    item[:publisher]       = first_item.get('publisher')
    item[:published]       = first_item.get('publicationdate')

    small_image  = first_item.search_and_convert('smallimage').first
    medium_image = first_item.search_and_convert('mediumimage').first
    large_image  = first_item.search_and_convert('largeimage').first

    item[:images] = {}
    item[:images][:small]  = _image_hash_from_element(small_image)
    item[:images][:medium] = _image_hash_from_element(medium_image)
    item[:images][:large]  = _image_hash_from_element(large_image)

    attrs = first_item.search_and_convert('itemattributes')

    item[:authors]       = attrs.get_array("author")
    item[:dewey_decimal] = attrs.get('deweydecimalnumber')
    item[:isbn]          = attrs.get('isbn')
    item[:ean]           = attrs.get('ean')
    item[:pages]         = attrs.get('numberofpages')
    item[:binding]       = attrs.get('binding')

    package = attrs.search_and_convert('packagedimensions')

    item[:height]       = package.get('height')
    item[:height_units] = package.elem.at('height')[:Units]
    item[:length]       = package.get('length')
    item[:length_units] = package.elem.at('height')[:Units]
    item[:width]        = package.get('width')
    item[:width_units]  = package.elem.at('width')[:Units]

    item
  end

  def _image_hash_from_element(element)
    {
      :url          => element.get('url'),
      :height       => element.get('height'),
      :height_units => element.elem.at('height')[:Units],
      :width        => element.get('width'),
      :width_units  => element.elem.at('width')[:Units]
    }
  end

  def _lookup(params)
    id           = params[:id]           || raise('ID required for lookup')
    id_type      = params[:id_type]      || raise('ID type required for lookup')
    search_index = params[:search_index] || raise('Search Index required for lookup')
    @error = nil

    res = Amazon::Ecs.item_lookup(
      id,
      {
        :response_group => 'Large',
        :id_type        => id_type,
        :search_index   => search_index
      }
    )
  end

  def _retrieve_aws_key
    key = Setting.find_by_key('aws_key')
    key.value
  end

  def _retrieve_aws_secret
    key = Setting.find_by_key('aws_secret')
    key.value
  end
end
