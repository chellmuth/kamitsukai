require 'test_helper'
require 'mocha'

class AmazonProductAdvertisingTest < ActiveSupport::TestCase

  test 'looks up key and secret from db' do
    a = AmazonProductAdvertising.new

    assert_equal a.aws_key, 'this is the aws key'
    assert_equal a.aws_secret, 'this is the aws secret'
  end

  test 'handles good book isbn request and response' do
    a = AmazonProductAdvertising.new
    Amazon::Ecs.expects(:item_lookup).with(
      'good',
      {
        :search_index => 'Books',
        :id_type => 'ISBN',
        :response_group => 'Large'
      }
    ).returns(Amazon::Ecs::Response.new(@sample_good_book_xml))

    response = a.lookup_book_edition_by_isbn('good')
    assert !a.has_error?
    assert_not_nil response
    assert_equal response,
      {
        :asin            => '0553380958',
        :detail_page_url => 'http://www.amazon.com/Snow-Crash-Bantam-Spectra-Book/dp/0553380958%3FSubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D0553380958',
        :publisher       => 'Spectra',
        :published       => '2000-05-02',
        :authors         => ['Neal Stephenson'],
        :dewey_decimal   => '813.54',
        :isbn            => '0553380958',
        :ean             => '9780553380958',
        :pages           => '480',
        :binding         => 'Paperback',
        :height          => '110',
        :height_units    => 'hundredths-inches',
        :length          => '820',
        :length_units    => 'hundredths-inches',
        :width           => '520',
        :width_units     => 'hundredths-inches',
        :images          => {
          :small  => {
            :url          => 'http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL75_.jpg',
            :height       => '75',
            :height_units => 'pixels',
            :width        => '47',
            :width_units  => 'pixels'
          },
          :medium => {
            :url          => 'http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL160_.jpg',
            :height       => '160',
            :height_units => 'pixels',
            :width        => '101',
            :width_units  => 'pixels'
          },
          :large  => {
            :url          => 'http://ecx.images-amazon.com/images/I/51XPYhRHtAL.jpg',
            :height       => '500',
            :height_units => 'pixels',
            :width        => '315',
            :width_units  => 'pixels'
          },
        }
      }
  end

  test 'handles bad book isbn request and matching response' do
    a = AmazonProductAdvertising.new
    Amazon::Ecs.expects(:item_lookup).with(
      'bad',
      {
        :search_index   => 'Books',
        :id_type        => 'ISBN',
        :response_group => 'Large'
      }
    ).returns(Amazon::Ecs::Response.new(@sample_bad_book_isbn_xml))

    response = a.lookup_book_edition_by_isbn('bad')
    assert a.has_error?
    assert_equal a.error, '1111111111 is not a valid value for ItemId. Please change this value and retry your request.'
    assert_nil response
  end

  test 'handles good book upc request and response' do
    a = AmazonProductAdvertising.new
    Amazon::Ecs.expects(:item_lookup).with(
      'good',
      {
        :search_index   => 'Books',
        :id_type        => 'UPC',
        :response_group => 'Large'
      }
    ).returns(Amazon::Ecs::Response.new(@sample_good_book_xml))

    response = a.lookup_book_edition_by_upc('good')
    assert !a.has_error?
    assert_not_nil response
    assert_equal response,
      {
        :asin            => '0553380958',
        :detail_page_url => 'http://www.amazon.com/Snow-Crash-Bantam-Spectra-Book/dp/0553380958%3FSubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D0553380958',
        :publisher       => 'Spectra',
        :published       => '2000-05-02',
        :authors         => ['Neal Stephenson'],
        :dewey_decimal   => '813.54',
        :isbn            => '0553380958',
        :ean             => '9780553380958',
        :pages           => '480',
        :binding         => 'Paperback',
        :height          => '110',
        :height_units    => 'hundredths-inches',
        :length          => '820',
        :length_units    => 'hundredths-inches',
        :width           => '520',
        :width_units     => 'hundredths-inches',
        :images          => {
          :small  => {
            :url          => 'http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL75_.jpg',
            :height       => '75',
            :height_units => 'pixels',
            :width        => '47',
            :width_units  => 'pixels'
          },
          :medium => {
            :url          => 'http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL160_.jpg',
            :height       => '160',
            :height_units => 'pixels',
            :width        => '101',
            :width_units  => 'pixels'
          },
          :large  => {
            :url          => 'http://ecx.images-amazon.com/images/I/51XPYhRHtAL.jpg',
            :height       => '500',
            :height_units => 'pixels',
            :width        => '315',
            :width_units  => 'pixels'
          },
        }
      }
  end

  test 'handles bad book upc request and matching response' do
    a = AmazonProductAdvertising.new
    Amazon::Ecs.expects(:item_lookup).with(
      'bad',
      {
        :search_index   => 'Books',
        :id_type        => 'UPC',
        :response_group => 'Large'
      }
    ).returns(Amazon::Ecs::Response.new(@sample_bad_book_upc_xml))

    response = a.lookup_book_edition_by_upc('bad')
    assert a.has_error?
    assert_equal a.error, '111111111111 is not a valid value for ItemId. Please change this value and retry your request.'
    assert_nil response
  end

  def setup
    Setting.create(:key => 'aws_key', :value => 'this is the aws key')
    Setting.create(:key => 'aws_secret', :value => 'this is the aws secret')


    @sample_good_book_xml = <<HERE
<?xml version="1.0" ?><ItemLookupResponse xmlns="http://webservices.amazon.com/AWSECommerceService/2008-10-06"><OperationRequest><HTTPHeaders><Header Name="UserAgent" Value="libwww-perl/5.820"></Header></HTTPHeaders><RequestId>9a1edc7c-3107-4ff3-85d1-71756ad1ecc9</RequestId><Arguments><Argument Name="Operation" Value="ItemLookup"></Argument><Argument Name="Service" Value="AWSECommerceService"></Argument><Argument Name="ItemId" Value="0553380958"></Argument><Argument Name="IdType" Value="ISBN"></Argument><Argument Name="AWSAccessKeyId" Value="1A190VPNHQTT4FWT25R2"></Argument><Argument Name="Timestamp" Value="2009-10-12T05:54:09Z"></Argument><Argument Name="Signature" Value="CJImTNut/jkvr+gl1Q4LFxIAf+vauoYRl9i/mn1SiiY="></Argument><Argument Name="ResponseGroup" Value="Large"></Argument><Argument Name="SearchIndex" Value="Books"></Argument><Argument Name="Version" Value="2009-01-01"></Argument></Arguments><RequestProcessingTime>0.0479680000000000</RequestProcessingTime></OperationRequest><Items><Request><IsValid>True</IsValid><ItemLookupRequest><Condition>New</Condition><DeliveryMethod>Ship</DeliveryMethod><IdType>ISBN</IdType><MerchantId>Amazon</MerchantId><OfferPage>1</OfferPage><ItemId>0553380958</ItemId><ResponseGroup>Large</ResponseGroup><ReviewPage>1</ReviewPage><ReviewSort>-SubmissionDate</ReviewSort><SearchIndex>Books</SearchIndex><VariationPage>All</VariationPage></ItemLookupRequest></Request><Item><ASIN>0553380958</ASIN><DetailPageURL>http://www.amazon.com/Snow-Crash-Bantam-Spectra-Book/dp/0553380958%3FSubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D0553380958</DetailPageURL><ItemLinks><ItemLink><Description>Technical Details</Description><URL>http://www.amazon.com/Snow-Crash-Bantam-Spectra-Book/dp/tech-data/0553380958%3FSubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink><ItemLink><Description>Add To Baby Registry</Description><URL>http://www.amazon.com/gp/registry/baby/add-item.html%3Fasin.0%3D0553380958%26SubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink><ItemLink><Description>Add To Wedding Registry</Description><URL>http://www.amazon.com/gp/registry/wedding/add-item.html%3Fasin.0%3D0553380958%26SubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink><ItemLink><Description>Add To Wishlist</Description><URL>http://www.amazon.com/gp/registry/wishlist/add-item.html%3Fasin.0%3D0553380958%26SubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink><ItemLink><Description>Tell A Friend</Description><URL>http://www.amazon.com/gp/pdp/taf/0553380958%3FSubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink><ItemLink><Description>All Customer Reviews</Description><URL>http://www.amazon.com/review/product/0553380958%3FSubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink><ItemLink><Description>All Offers</Description><URL>http://www.amazon.com/gp/offer-listing/0553380958%3FSubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink></ItemLinks><SalesRank>3309</SalesRank><SmallImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL75_.jpg</URL><Height Units="pixels">75</Height><Width Units="pixels">47</Width></SmallImage><MediumImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL160_.jpg</URL><Height Units="pixels">160</Height><Width Units="pixels">101</Width></MediumImage><LargeImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL.jpg</URL><Height Units="pixels">500</Height><Width Units="pixels">315</Width></LargeImage><ImageSets><ImageSet Category="primary"><SwatchImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL30_.jpg</URL><Height Units="pixels">30</Height><Width Units="pixels">19</Width></SwatchImage><SmallImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL75_.jpg</URL><Height Units="pixels">75</Height><Width Units="pixels">47</Width></SmallImage><ThumbnailImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL75_.jpg</URL><Height Units="pixels">75</Height><Width Units="pixels">47</Width></ThumbnailImage><TinyImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL110_.jpg</URL><Height Units="pixels">110</Height><Width Units="pixels">69</Width></TinyImage><MediumImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL160_.jpg</URL><Height Units="pixels">160</Height><Width Units="pixels">101</Width></MediumImage><LargeImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL.jpg</URL><Height Units="pixels">500</Height><Width Units="pixels">315</Width></LargeImage></ImageSet></ImageSets><ItemAttributes><Author>Neal Stephenson</Author><Binding>Paperback</Binding><DeweyDecimalNumber>813.54</DeweyDecimalNumber><EAN>9780553380958</EAN><Feature>ISBN13: 9780553380958</Feature><Feature>Condition: NEW</Feature><Feature>Notes: Brand New from Publisher. No Remainder Mark.</Feature><Feature>&lt;a title='Condition Guide' href='/content/Condition_and_Shipping_Guide.htm' target='_blank'&gt;Click here to view our Condition Guide and Shipping Prices&lt;/a&gt;</Feature><ISBN>0553380958</ISBN><Label>Spectra</Label><Languages><Language><Name>English</Name><Type>Original Language</Type></Language><Language><Name>English</Name><Type>Unknown</Type></Language><Language><Name>English</Name><Type>Published</Type></Language></Languages><ListPrice><Amount>1500</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$15.00</FormattedPrice></ListPrice><Manufacturer>Spectra</Manufacturer><NumberOfItems>1</NumberOfItems><NumberOfPages>480</NumberOfPages><PackageDimensions><Height Units="hundredths-inches">110</Height><Length Units="hundredths-inches">820</Length><Weight Units="hundredths-pounds">85</Weight><Width Units="hundredths-inches">520</Width></PackageDimensions><ProductGroup>Book</ProductGroup><ProductTypeName>ABIS_BOOK</ProductTypeName><PublicationDate>2000-05-02</PublicationDate><Publisher>Spectra</Publisher><ReleaseDate>2000-05-02</ReleaseDate><Studio>Spectra</Studio><Title>Snow Crash (Bantam Spectra Book)</Title></ItemAttributes><OfferSummary><LowestNewPrice><Amount>725</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$7.25</FormattedPrice></LowestNewPrice><LowestUsedPrice><Amount>314</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$3.14</FormattedPrice></LowestUsedPrice><LowestCollectiblePrice><Amount>1500</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$15.00</FormattedPrice></LowestCollectiblePrice><TotalNew>43</TotalNew><TotalUsed>104</TotalUsed><TotalCollectible>6</TotalCollectible><TotalRefurbished>0</TotalRefurbished></OfferSummary><Offers><TotalOffers>1</TotalOffers><TotalOfferPages>1</TotalOfferPages><Offer><Merchant><MerchantId>ATVPDKIKX0DER</MerchantId><GlancePage>http://www.amazon.com/gp/help/seller/home.html?seller=ATVPDKIKX0DER</GlancePage><AverageFeedbackRating>0.0</AverageFeedbackRating><TotalFeedback>0</TotalFeedback></Merchant><OfferAttributes><Condition>New</Condition><SubCondition>new</SubCondition></OfferAttributes><OfferListing><OfferListingId>%2BSqp%2FZKT7srsCrUt3N32n74ccBWpeZQRYv1PkAKlWkFClnCcbS1zbg1gFva3SIXogkjZk1ZPyST2iBJ8SjQ%2FKQ%3D%3D</OfferListingId><Price><Amount>1020</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$10.20</FormattedPrice></Price><AmountSaved><Amount>480</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$4.80</FormattedPrice></AmountSaved><PercentageSaved>32</PercentageSaved><Availability>Usually ships in 24 hours</Availability><AvailabilityAttributes><AvailabilityType>now</AvailabilityType><MinimumHours>0</MinimumHours><MaximumHours>0</MaximumHours></AvailabilityAttributes><Quantity>-1</Quantity><IsEligibleForSuperSaverShipping>1</IsEligibleForSuperSaverShipping></OfferListing></Offer></Offers><CustomerReviews><AverageRating>4.0</AverageRating><TotalReviews>573</TotalReviews><TotalReviewPages>115</TotalReviewPages><Review><ASIN>0553380958</ASIN><Rating>3</Rating><HelpfulVotes>0</HelpfulVotes><CustomerId>AF41ZGB6YQZUJ</CustomerId><Reviewer><CustomerId>AF41ZGB6YQZUJ</CustomerId><Name>Luke Terheyden</Name></Reviewer><TotalVotes>0</TotalVotes><Date>2009-10-01</Date><Summary>Entertaining.</Summary><Content>Snow Crash is a pretty entertaining read, especially for the gadget-oriented. There is a lot of fun computer hacking, sword fights, and explosions, and the characters are pretty well developed.
HERE

    @sample_bad_book_isbn_xml = <<HERE
<?xml version="1.0" ?><ItemLookupResponse xmlns="http://webservices.amazon.com/AWSECommerceService/2008-10-06"><OperationRequest><HTTPHeaders><Header Name="UserAgent" Value="libwww-perl/5.820"></Header></HTTPHeaders><RequestId>fbccd2f4-d0d0-4126-8665-6c70eefe8972</RequestId><Arguments><Argument Name="Operation" Value="ItemLookup"></Argument><Argument Name="Service" Value="AWSECommerceService"></Argument><Argument Name="ItemId" Value="1111111111"></Argument><Argument Name="IdType" Value="ISBN"></Argument><Argument Name="AWSAccessKeyId" Value="1A190VPNHQTT4FWT25R2"></Argument><Argument Name="Timestamp" Value="2009-10-12T06:06:02Z"></Argument><Argument Name="Signature" Value="DwiK+OX8gqEaHB/VYknFPPlOfmTMHrIXAr4kuO5wfGQ="></Argument><Argument Name="ResponseGroup" Value="Large"></Argument><Argument Name="SearchIndex" Value="Books"></Argument><Argument Name="Version" Value="2009-01-01"></Argument></Arguments><RequestProcessingTime>0.1093970000000000</RequestProcessingTime></OperationRequest><Items><Request><IsValid>True</IsValid><ItemLookupRequest><Condition>New</Condition><DeliveryMethod>Ship</DeliveryMethod><IdType>ISBN</IdType><MerchantId>Amazon</MerchantId><OfferPage>1</OfferPage><ItemId>1111111111</ItemId><ResponseGroup>Large</ResponseGroup><ReviewPage>1</ReviewPage><ReviewSort>-SubmissionDate</ReviewSort><SearchIndex>Books</SearchIndex><VariationPage>All</VariationPage></ItemLookupRequest><Errors><Error><Code>AWS.InvalidParameterValue</Code><Message>1111111111 is not a valid value for ItemId. Please change this value and retry your request.</Message></Error></Errors></Request></Items></ItemLookupResponse>
HERE

    @sample_bad_book_upc_xml = <<HERE
<?xml version="1.0" ?><ItemLookupResponse xmlns="http://webservices.amazon.com/AWSECommerceService/2008-10-06"><OperationRequest><HTTPHeaders><Header Name="UserAgent" Value="libwww-perl/5.820"></Header></HTTPHeaders><RequestId>3f45f8ea-634a-4e0e-ba66-274c1702f49e</RequestId><Arguments><Argument Name="Operation" Value="ItemLookup"></Argument><Argument Name="Service" Value="AWSECommerceService"></Argument><Argument Name="Signature" Value="/XhzqH0WQZRUkCSHewutr4TgugYMPoJgvWHAsgJ8qp8="></Argument><Argument Name="Version" Value="2009-01-01"></Argument><Argument Name="ItemId" Value="111111111111"></Argument><Argument Name="IdType" Value="UPC"></Argument><Argument Name="AWSAccessKeyId" Value="1A190VPNHQTT4FWT25R2"></Argument><Argument Name="Timestamp" Value="2009-10-13T05:19:24Z"></Argument><Argument Name="ResponseGroup" Value="Large"></Argument><Argument Name="SearchIndex" Value="Books"></Argument></Arguments><RequestProcessingTime>0.0264580000000000</RequestProcessingTime></OperationRequest><Items><Request><IsValid>True</IsValid><ItemLookupRequest><Condition>New</Condition><DeliveryMethod>Ship</DeliveryMethod><IdType>UPC</IdType><MerchantId>Amazon</MerchantId><OfferPage>1</OfferPage><ItemId>111111111111</ItemId><ResponseGroup>Large</ResponseGroup><ReviewPage>1</ReviewPage><ReviewSort>-SubmissionDate</ReviewSort><SearchIndex>Books</SearchIndex><VariationPage>All</VariationPage></ItemLookupRequest><Errors><Error><Code>AWS.InvalidParameterValue</Code><Message>111111111111 is not a valid value for ItemId. Please change this value and retry your request.</Message></Error></Errors></Request></Items></ItemLookupResponse>
HERE
  end
end