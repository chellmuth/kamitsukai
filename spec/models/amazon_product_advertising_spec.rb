require 'spec_helper'

describe 'An AmazonProductAdvertising' do
  before(:all) do
    @key = Setting.create(:key => 'aws_key', :value => 'this is the aws key')
    @secret = Setting.create(:key => 'aws_secret', :value => 'this is the aws secret')
  end

  after(:all) do
    @key.destroy
    @secret.destroy
  end

  it 'should use the AWS key, and secret from Setting' do
    a = AmazonProductAdvertising.new

    a.aws_key.should == 'this is the aws key'
    a.aws_secret.should == 'this is the aws secret'
  end

  context 'book' do
    before(:all) do
      @good_book_xml = <<-HERE
        <?xml version="1.0" ?><ItemLookupResponse xmlns="http://webservices.amazon.com/AWSECommerceService/2008-10-06"><OperationRequest><HTTPHeaders><Header Name="UserAgent" Value="libwww-perl/5.820"></Header></HTTPHeaders><RequestId>9a1edc7c-3107-4ff3-85d1-71756ad1ecc9</RequestId><Arguments><Argument Name="Operation" Value="ItemLookup"></Argument><Argument Name="Service" Value="AWSECommerceService"></Argument><Argument Name="ItemId" Value="0553380958"></Argument><Argument Name="IdType" Value="ISBN"></Argument><Argument Name="AWSAccessKeyId" Value="1A190VPNHQTT4FWT25R2"></Argument><Argument Name="Timestamp" Value="2009-10-12T05:54:09Z"></Argument><Argument Name="Signature" Value="CJImTNut/jkvr+gl1Q4LFxIAf+vauoYRl9i/mn1SiiY="></Argument><Argument Name="ResponseGroup" Value="Large"></Argument><Argument Name="SearchIndex" Value="Books"></Argument><Argument Name="Version" Value="2009-01-01"></Argument></Arguments><RequestProcessingTime>0.0479680000000000</RequestProcessingTime></OperationRequest><Items><Request><IsValid>True</IsValid><ItemLookupRequest><Condition>New</Condition><DeliveryMethod>Ship</DeliveryMethod><IdType>ISBN</IdType><MerchantId>Amazon</MerchantId><OfferPage>1</OfferPage><ItemId>0553380958</ItemId><ResponseGroup>Large</ResponseGroup><ReviewPage>1</ReviewPage><ReviewSort>-SubmissionDate</ReviewSort><SearchIndex>Books</SearchIndex><VariationPage>All</VariationPage></ItemLookupRequest></Request><Item><ASIN>0553380958</ASIN><DetailPageURL>http://www.amazon.com/Snow-Crash-Bantam-Spectra-Book/dp/0553380958%3FSubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D0553380958</DetailPageURL><ItemLinks><ItemLink><Description>Technical Details</Description><URL>http://www.amazon.com/Snow-Crash-Bantam-Spectra-Book/dp/tech-data/0553380958%3FSubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink><ItemLink><Description>Add To Baby Registry</Description><URL>http://www.amazon.com/gp/registry/baby/add-item.html%3Fasin.0%3D0553380958%26SubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink><ItemLink><Description>Add To Wedding Registry</Description><URL>http://www.amazon.com/gp/registry/wedding/add-item.html%3Fasin.0%3D0553380958%26SubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink><ItemLink><Description>Add To Wishlist</Description><URL>http://www.amazon.com/gp/registry/wishlist/add-item.html%3Fasin.0%3D0553380958%26SubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink><ItemLink><Description>Tell A Friend</Description><URL>http://www.amazon.com/gp/pdp/taf/0553380958%3FSubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink><ItemLink><Description>All Customer Reviews</Description><URL>http://www.amazon.com/review/product/0553380958%3FSubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink><ItemLink><Description>All Offers</Description><URL>http://www.amazon.com/gp/offer-listing/0553380958%3FSubscriptionId%3D1A190VPNHQTT4FWT25R2%26tag%3Dws%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0553380958</URL></ItemLink></ItemLinks><SalesRank>3309</SalesRank><SmallImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL75_.jpg</URL><Height Units="pixels">75</Height><Width Units="pixels">47</Width></SmallImage><MediumImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL160_.jpg</URL><Height Units="pixels">160</Height><Width Units="pixels">101</Width></MediumImage><LargeImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL.jpg</URL><Height Units="pixels">500</Height><Width Units="pixels">315</Width></LargeImage><ImageSets><ImageSet Category="primary"><SwatchImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL30_.jpg</URL><Height Units="pixels">30</Height><Width Units="pixels">19</Width></SwatchImage><SmallImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL75_.jpg</URL><Height Units="pixels">75</Height><Width Units="pixels">47</Width></SmallImage><ThumbnailImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL75_.jpg</URL><Height Units="pixels">75</Height><Width Units="pixels">47</Width></ThumbnailImage><TinyImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL110_.jpg</URL><Height Units="pixels">110</Height><Width Units="pixels">69</Width></TinyImage><MediumImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL._SL160_.jpg</URL><Height Units="pixels">160</Height><Width Units="pixels">101</Width></MediumImage><LargeImage><URL>http://ecx.images-amazon.com/images/I/51XPYhRHtAL.jpg</URL><Height Units="pixels">500</Height><Width Units="pixels">315</Width></LargeImage></ImageSet></ImageSets><ItemAttributes><Author>Neal Stephenson</Author><Binding>Paperback</Binding><DeweyDecimalNumber>813.54</DeweyDecimalNumber><EAN>9780553380958</EAN><Feature>ISBN13: 9780553380958</Feature><Feature>Condition: NEW</Feature><Feature>Notes: Brand New from Publisher. No Remainder Mark.</Feature><Feature>&lt;a title='Condition Guide' href='/content/Condition_and_Shipping_Guide.htm' target='_blank'&gt;Click here to view our Condition Guide and Shipping Prices&lt;/a&gt;</Feature><ISBN>0553380958</ISBN><Label>Spectra</Label><Languages><Language><Name>English</Name><Type>Original Language</Type></Language><Language><Name>English</Name><Type>Unknown</Type></Language><Language><Name>English</Name><Type>Published</Type></Language></Languages><ListPrice><Amount>1500</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$15.00</FormattedPrice></ListPrice><Manufacturer>Spectra</Manufacturer><NumberOfItems>1</NumberOfItems><NumberOfPages>480</NumberOfPages><PackageDimensions><Height Units="hundredths-miles">110</Height><Length Units="hundredths-miles">820</Length><Weight Units="hundredths-pounds">85</Weight><Width Units="hundredths-miles">520</Width></PackageDimensions><ProductGroup>Book</ProductGroup><ProductTypeName>ABIS_BOOK</ProductTypeName><PublicationDate>2000-05-02</PublicationDate><Publisher>Spectra</Publisher><ReleaseDate>2000-05-02</ReleaseDate><Studio>Spectra</Studio><Title>Snow Crash (Bantam Spectra Book)</Title></ItemAttributes><OfferSummary><LowestNewPrice><Amount>725</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$7.25</FormattedPrice></LowestNewPrice><LowestUsedPrice><Amount>314</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$3.14</FormattedPrice></LowestUsedPrice><LowestCollectiblePrice><Amount>1500</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$15.00</FormattedPrice></LowestCollectiblePrice><TotalNew>43</TotalNew><TotalUsed>104</TotalUsed><TotalCollectible>6</TotalCollectible><TotalRefurbished>0</TotalRefurbished></OfferSummary><Offers><TotalOffers>1</TotalOffers><TotalOfferPages>1</TotalOfferPages><Offer><Merchant><MerchantId>ATVPDKIKX0DER</MerchantId><GlancePage>http://www.amazon.com/gp/help/seller/home.html?seller=ATVPDKIKX0DER</GlancePage><AverageFeedbackRating>0.0</AverageFeedbackRating><TotalFeedback>0</TotalFeedback></Merchant><OfferAttributes><Condition>New</Condition><SubCondition>new</SubCondition></OfferAttributes><OfferListing><OfferListingId>%2BSqp%2FZKT7srsCrUt3N32n74ccBWpeZQRYv1PkAKlWkFClnCcbS1zbg1gFva3SIXogkjZk1ZPyST2iBJ8SjQ%2FKQ%3D%3D</OfferListingId><Price><Amount>1020</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$10.20</FormattedPrice></Price><AmountSaved><Amount>480</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$4.80</FormattedPrice></AmountSaved><PercentageSaved>32</PercentageSaved><Availability>Usually ships in 24 hours</Availability><AvailabilityAttributes><AvailabilityType>now</AvailabilityType><MinimumHours>0</MinimumHours><MaximumHours>0</MaximumHours></AvailabilityAttributes><Quantity>-1</Quantity><IsEligibleForSuperSaverShipping>1</IsEligibleForSuperSaverShipping></OfferListing></Offer></Offers><CustomerReviews><AverageRating>4.0</AverageRating><TotalReviews>573</TotalReviews><TotalReviewPages>115</TotalReviewPages><Review><ASIN>0553380958</ASIN><Rating>3</Rating><HelpfulVotes>0</HelpfulVotes><CustomerId>AF41ZGB6YQZUJ</CustomerId><Reviewer><CustomerId>AF41ZGB6YQZUJ</CustomerId><Name>Luke Terheyden</Name></Reviewer><TotalVotes>0</TotalVotes><Date>2009-10-01</Date><Summary>Entertaining.</Summary><Content>Snow Crash is a pretty entertaining read, especially for the gadget-oriented. There is a lot of fun computer hacking, sword fights, and explosions, and the characters are pretty well developed.&lt;br /&gt;&lt;br /&gt;The backstory behind the main antagonist is unique; the author weaves ancient Sumerian mythology with Human physiology to create a sort of computer language of the human mind. It's interesting, but I think the time Hiro (the main character) spends in the library studying Sumerian lore should have been condensed. The book otherwise has a very good pace.&lt;br /&gt;&lt;br /&gt;Snow Crash is mostly an external adventure. What I mean is, the main characters don't do a lot of growing throughout the book. They pretty much are who they are, and they're out to get the bad guy. It's like watching a good action flick. That's why I gave it 3 rather than 5 stars. For me, the development and conclusion of the anagnorisis, that 'ah-ha' moment, is most enjoyable.&lt;br /&gt;</Content></Review><Review><ASIN>0553380958</ASIN><Rating>4</Rating><HelpfulVotes>0</HelpfulVotes><CustomerId>A1RL3IZAS2AE7V</CustomerId><Reviewer><CustomerId>A1RL3IZAS2AE7V</CustomerId><Name>L. Kasprzyk</Name><Nickname>Leila K.</Nickname><Location>Austin, TX United States</Location></Reviewer><TotalVotes>0</TotalVotes><Date>2009-09-24</Date><Summary>Really well written</Summary><Content>Well written fast paced novel that does not read like cyber-punk. The book slows occasionally as we learn about language and viruses but this only adds to the book. </Content></Review><Review><ASIN>0553380958</ASIN><Rating>4</Rating><HelpfulVotes>2</HelpfulVotes><CustomerId>A26KHZE0HTS057</CustomerId><Reviewer><CustomerId>A26KHZE0HTS057</CustomerId><Name>Burgmicester</Name><Location>Pittsburgh</Location></Reviewer><TotalVotes>2</TotalVotes><Date>2009-08-26</Date><Summary>I feel so "with it" after a Stephenson Novel</Summary><Content>Neal Stephenson has a knack for making this 50+ year old reader feel like he just had a heck of a run down the longest ski slope in Colorado.  It is not often that I feel so "with it" as I do after being able to keep up with the rapid flow of verse, eye popping word candy and just out and out futuristic fun from another novel by Stephenson.  The first time I read anything by Stephenson, it was Cryptonomicon, a 1200 page book that went by in a very short time without any boredom at all.  So I dug up the scoop on his books and found another well liked book was Snow Crash.  When you read a Neal Stephenson novel, the take-off begins on the opening page and then it's full steam ahead for the rest of the book.  Oh, sure, in Stephenson fashion, he meanders a bit into tangential imagery and off topics looks at the weird and wild, but it's all done in nanoseconds.  &lt;br /&gt;&lt;br /&gt;Snow Crash has been explained ad infinitum for 500+ reviews, so I will not bore you with the details, but roughly, this book takes place in the future.  All that is left of the official United States of America is a group of Federal Buildings on a campus somewhere near L.A.  The land mass known as the lower 48 in today's lingo is now a variety of little burbclaves, each with a ruling president of sorts but not like a political country, but a company/city-state mixed with business and politics.  For example, there are franchise companies/countries such as Mr. Lee's Greater Hong Kong, Reverend Wayne and the Pearly Gates, the Nipponese Quadrant and Uncle Enzo's Mafia among others.  Crime can be driven out by a menacing robotic/biomass dog-like creature that can move at almost the speed of somewhere-between-sound-and-light.  The Police forces have become large for profit as the MetaCops and Enforcers take different tacks to keep the peace.  &lt;br /&gt;&lt;br /&gt;Pizza delivery is the opening segment and it is "a riot, Alice, a real riot" to quote Jackie Gleason.  The names of the main characters should give away some of the thought process of Stephenson as Hiro Protagonist tries to keep his partner Y.T. (no, not Whitey) from getting killed.  Although as a one of the best Kouriers in the New World, she can take care of herself pretty well.  &lt;br /&gt;&lt;br /&gt;Reality and the online world of the Metaverse have become meshed and where one starts the other leaves off has become a gray area.  Much of the analysis of what is happening was out of my reach for a long while in the book.  Then with a deft piece of writing, Stephenson brings all of the pieces together with quite an interesting proposition on about page 400.  His genius is illustrated with this fascinating look at language skills, human comprehension and viral infection.  I know, it sounds whacky; and it is, but no less fascinating.&lt;br /&gt;&lt;br /&gt;The best explanation I can come up with is this is like reading a book by H.G. Wells while he was on speed with side orders of Stephen King and Kurt Vonnegut.&lt;br /&gt;</Content></Review><Review><ASIN>0553380958</ASIN><Rating>3</Rating><HelpfulVotes>2</HelpfulVotes><CustomerId>AHX9I7RPXXLBL</CustomerId><Reviewer><CustomerId>AHX9I7RPXXLBL</CustomerId><Name>J. Orach</Name><Location>Boston, MA</Location></Reviewer><TotalVotes>2</TotalVotes><Date>2009-08-10</Date><Summary>Kindle Edition Flawed</Summary><Content>I enjoyed the book, I won't go in depth about its plot as plenty of other people have already done that. I liked the story and thought it was a fun weekend read.&lt;br /&gt;&lt;br /&gt;The Kindle version has a ton of formatting errors that make me feel like my $10 wasn't well spent. There are typos galore as if it were scanned and quickly OCRed (words like "chaos" appear as "chacs"), and words that were hyphenated due to the end of a line in print remain hyphenated... in the middle of sen-tences. It's distracting and very annoying for a $10 product. &lt;br /&gt;&lt;br /&gt;At the end of the book it appears Snow Crash was created as an eBook in 2003. This Kindle store version is a quick cash grab and it would be nice if Amazon would convince the publisher to fix it.</Content></Review><Review><ASIN>0553380958</ASIN><Rating>4</Rating><HelpfulVotes>1</HelpfulVotes><CustomerId>A37DTO57JS15PX</CustomerId><Reviewer><CustomerId>A37DTO57JS15PX</CustomerId><Name>The Czar of Arkansas</Name><Location>Little Rock, AR USA</Location></Reviewer><TotalVotes>1</TotalVotes><Date>2009-08-01</Date><Summary>Solid Cyberpunk</Summary><Content>The plot to Snow Crash has been covered in many other reviews, so I won't recount it in this review.  I found Snow Crash to be excellent cyberpunk.&lt;br /&gt;&lt;br /&gt;Stephenson creates what is probably the most completely realized world in cyberpunk.  The vision he has of a world where the United States has become balkanized, corporations rule civilization, and the virtual world rivals that of the real world in importance is painstakingly rendered.  His prose flows off the page and makes Snow Crash a page turner.  The characters in the book are well-developed and interesting.&lt;br /&gt;&lt;br /&gt;The book, in my opinion, has three negative qualities:&lt;br /&gt;&lt;br /&gt;1.  Snow Crash has lots of exposition.  No, really.  Lots.  In Stephenson's defense, this exposition is very artfully handled; however, if you find long explanations tedious, be warned.  &lt;br /&gt;&lt;br /&gt;2.  The central tenet of the work, while exceptionally creative and well-researched, only holds if you don't think much about it.  All science-fiction requires suspension of disbelief, but this tenet is pretty out there.&lt;br /&gt;&lt;br /&gt;3.  The ending is extremely abrupt.  The book actually stops more than it ends, leaving the reader without any idea of what happened to key characters.  Some ambiguity can serve a novel well if it provokes the reader to introspection, but the end of Snow Crash comes off as unfinished rather than thought provoking.&lt;br /&gt;&lt;br /&gt;Snow Crash, is however, one of the top two or three cyberpunk books I've ever read, and it's the most ingeniously crafted.  While it has flaws, its oustanding even with them.</Content></Review></CustomerReviews><EditorialReviews><EditorialReview><Source>Product Description</Source><Content>Only once in a great while does a writer come along who defies comparison--a writer so original he redefines the way we look at the world. Neal Stephenson is such a writer and &lt;B&gt;Snow Crash&lt;/B&gt; is such a novel, weaving virtual reality, Sumerian myth, and just about everything in between with a cool, hip cybersensibility to bring us the gigathriller of the information age.&lt;br&gt;&lt;br&gt;In reality, Hiro Protagonist delivers pizza for Uncle Enzo's CosaNostra Pizza Inc., but in the Metaverse he's a warrior prince. Plunging headlong into the enigma of a new computer virus that's striking down hackers everywhere, he races along the neon-lit streets on a search-and-destroy mission for the shadowy virtual villain threatening to bring about Infocalypse. &lt;B&gt;Snow Crash&lt;/B&gt; is a mind-altering romp through a future America so bizarre, so outrageous...you'll recognize it immediately.&lt;br&gt;</Content><IsLinkSuppressed>0</IsLinkSuppressed></EditorialReview><EditorialReview><Source>Amazon.com Review</Source><Content>From the opening line of his breakthrough cyberpunk novel  &lt;I&gt;Snow Crash&lt;/I&gt;, Neal Stephenson plunges the reader into a  not-too-distant future. It is a world where the Mafia controls pizza  delivery, the United States exists as a patchwork of  corporate-franchise city-states, and the Internet--incarnate as the  Metaverse--looks something like last year's hype would lead you to  believe it should. Enter Hiro Protagonist--hacker, samurai swordsman,  and pizza-delivery driver. When his best friend fries his brain on a  new designer drug called Snow Crash and his beautiful, brainy  ex-girlfriend asks for his help, what's a guy with a name like that to  do? He rushes to the rescue. A breakneck-paced 21st-century novel,  &lt;I&gt;Snow Crash&lt;/I&gt; interweaves everything from Sumerian myth to visions  of a postmodern civilization on the brink of collapse. Faster than the  speed of television and a whole lot more fun, &lt;I&gt;Snow Crash&lt;/I&gt; is the  portrayal of a future that is bizarre enough to be plausible.  </Content><IsLinkSuppressed>0</IsLinkSuppressed></EditorialReview></EditorialReviews><SimilarProducts><SimilarProduct><ASIN>0553380966</ASIN><Title>The Diamond Age: Or, a Young Lady's Illustrated Primer (Bantam Spectra Book)</Title></SimilarProduct><SimilarProduct><ASIN>0060512806</ASIN><Title>Cryptonomicon</Title></SimilarProduct><SimilarProduct><ASIN>0441569595</ASIN><Title>Neuromancer</Title></SimilarProduct><SimilarProduct><ASIN>0802143156</ASIN><Title>Zodiac</Title></SimilarProduct><SimilarProduct><ASIN>0060593083</ASIN><Title>Quicksilver (The Baroque Cycle, Vol. 1)</Title></SimilarProduct></SimilarProducts><BrowseNodes><BrowseNode><BrowseNodeId>713014011</BrowseNodeId><Name>General AAS</Name><Ancestors><BrowseNode><BrowseNodeId>319654011</BrowseNodeId><Name>Qualifying Textbooks</Name><Ancestors><BrowseNode><BrowseNodeId>251254011</BrowseNodeId><Name>Custom Stores</Name><Ancestors><BrowseNode><BrowseNodeId>44258011</BrowseNodeId><Name>Specialty Stores</Name><Ancestors><BrowseNode><BrowseNodeId>283155</BrowseNodeId><Name>Books</Name></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode><BrowseNode><BrowseNodeId>284615</BrowseNodeId><Name>General</Name><Ancestors><BrowseNode><BrowseNodeId>15987</BrowseNodeId><Name>Stephenson, Neal</Name><Ancestors><BrowseNode><BrowseNodeId>15869</BrowseNodeId><Name>( S )</Name><Ancestors><BrowseNode><BrowseNodeId>14652</BrowseNodeId><Name>Authors, A-Z</Name><Ancestors><BrowseNode><BrowseNodeId>25</BrowseNodeId><Name>Science Fiction &amp; Fantasy</Name><Ancestors><BrowseNode><BrowseNodeId>1000</BrowseNodeId><Name>Subjects</Name><IsCategoryRoot>1</IsCategoryRoot><Ancestors><BrowseNode><BrowseNodeId>283155</BrowseNodeId><Name>Books</Name></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode><BrowseNode><BrowseNodeId>285633</BrowseNodeId><Name>Paperback</Name><Ancestors><BrowseNode><BrowseNodeId>15987</BrowseNodeId><Name>Stephenson, Neal</Name><Ancestors><BrowseNode><BrowseNodeId>15869</BrowseNodeId><Name>( S )</Name><Ancestors><BrowseNode><BrowseNodeId>14652</BrowseNodeId><Name>Authors, A-Z</Name><Ancestors><BrowseNode><BrowseNodeId>25</BrowseNodeId><Name>Science Fiction &amp; Fantasy</Name><Ancestors><BrowseNode><BrowseNodeId>1000</BrowseNodeId><Name>Subjects</Name><IsCategoryRoot>1</IsCategoryRoot><Ancestors><BrowseNode><BrowseNodeId>283155</BrowseNodeId><Name>Books</Name></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode><BrowseNode><BrowseNodeId>713740011</BrowseNodeId><Name>General AAS</Name><Ancestors><BrowseNode><BrowseNodeId>15987</BrowseNodeId><Name>Stephenson, Neal</Name><Ancestors><BrowseNode><BrowseNodeId>15869</BrowseNodeId><Name>( S )</Name><Ancestors><BrowseNode><BrowseNodeId>14652</BrowseNodeId><Name>Authors, A-Z</Name><Ancestors><BrowseNode><BrowseNodeId>25</BrowseNodeId><Name>Science Fiction &amp; Fantasy</Name><Ancestors><BrowseNode><BrowseNodeId>1000</BrowseNodeId><Name>Subjects</Name><IsCategoryRoot>1</IsCategoryRoot><Ancestors><BrowseNode><BrowseNodeId>283155</BrowseNodeId><Name>Books</Name></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode><BrowseNode><BrowseNodeId>16286</BrowseNodeId><Name>High Tech</Name><Ancestors><BrowseNode><BrowseNodeId>16272</BrowseNodeId><Name>Science Fiction</Name><Ancestors><BrowseNode><BrowseNodeId>25</BrowseNodeId><Name>Science Fiction &amp; Fantasy</Name><Ancestors><BrowseNode><BrowseNodeId>1000</BrowseNodeId><Name>Subjects</Name><IsCategoryRoot>1</IsCategoryRoot><Ancestors><BrowseNode><BrowseNodeId>283155</BrowseNodeId><Name>Books</Name></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode><BrowseNode><BrowseNodeId>16282</BrowseNodeId><Name>General</Name><Ancestors><BrowseNode><BrowseNodeId>16272</BrowseNodeId><Name>Science Fiction</Name><Ancestors><BrowseNode><BrowseNodeId>25</BrowseNodeId><Name>Science Fiction &amp; Fantasy</Name><Ancestors><BrowseNode><BrowseNodeId>1000</BrowseNodeId><Name>Subjects</Name><IsCategoryRoot>1</IsCategoryRoot><Ancestors><BrowseNode><BrowseNodeId>283155</BrowseNodeId><Name>Books</Name></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode><BrowseNode><BrowseNodeId>713749011</BrowseNodeId><Name>General AAS</Name><Ancestors><BrowseNode><BrowseNodeId>16272</BrowseNodeId><Name>Science Fiction</Name><Ancestors><BrowseNode><BrowseNodeId>25</BrowseNodeId><Name>Science Fiction &amp; Fantasy</Name><Ancestors><BrowseNode><BrowseNodeId>1000</BrowseNodeId><Name>Subjects</Name><IsCategoryRoot>1</IsCategoryRoot><Ancestors><BrowseNode><BrowseNodeId>283155</BrowseNodeId><Name>Books</Name></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode><BrowseNode><BrowseNodeId>713718011</BrowseNodeId><Name>General</Name><Ancestors><BrowseNode><BrowseNodeId>25</BrowseNodeId><Name>Science Fiction &amp; Fantasy</Name><Ancestors><BrowseNode><BrowseNodeId>1000</BrowseNodeId><Name>Subjects</Name><IsCategoryRoot>1</IsCategoryRoot><Ancestors><BrowseNode><BrowseNodeId>283155</BrowseNodeId><Name>Books</Name></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode><BrowseNode><BrowseNodeId>400272011</BrowseNodeId><Name>Paperback</Name><Children><BrowseNode><BrowseNodeId>394184011</BrowseNodeId><Name>Mass Market</Name></BrowseNode><BrowseNode><BrowseNodeId>401237011</BrowseNodeId><Name>Trade</Name></BrowseNode></Children><Ancestors><BrowseNode><BrowseNodeId>394174011</BrowseNodeId><Name>Binding (binding)</Name><Ancestors><BrowseNode><BrowseNodeId>388186011</BrowseNodeId><Name>Refinements</Name><Ancestors><BrowseNode><BrowseNodeId>283155</BrowseNodeId><Name>Books</Name></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode><BrowseNode><BrowseNodeId>618083011</BrowseNodeId><Name>Printed Books</Name><Ancestors><BrowseNode><BrowseNodeId>618072011</BrowseNodeId><Name>Format (feature_browse-bin)</Name><Ancestors><BrowseNode><BrowseNodeId>388186011</BrowseNodeId><Name>Refinements</Name><Ancestors><BrowseNode><BrowseNodeId>283155</BrowseNodeId><Name>Books</Name></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></Ancestors></BrowseNode></BrowseNodes><ListmaniaLists><ListmaniaList><ListId>R2GUQR2DPOQLP2</ListId><ListName>Best Cyberpunk Novels</ListName></ListmaniaList><ListmaniaList><ListId>R3R42DP1I2U903</ListId><ListName>Post Modern, Warped, and Highly Innovative</ListName></ListmaniaList><ListmaniaList><ListId>R24M9WVQN12IEA</ListId><ListName>My favorite Cyberpunk books and a movie</ListName></ListmaniaList><ListmaniaList><ListId>R3HZHZ83VFOWKR</ListId><ListName>Top Science Fiction Books</ListName></ListmaniaList><ListmaniaList><ListId>R1NQ5WXMJNG4AR</ListId><ListName>Scifi favorites</ListName></ListmaniaList><ListmaniaList><ListId>R1KOZ0OP5W33F</ListId><ListName>Books That Had an Impact</ListName></ListmaniaList><ListmaniaList><ListId>R3IX7BBYCF4KJ1</ListId><ListName>My Top 5 Favorite Books (that everyone should read)</ListName></ListmaniaList><ListmaniaList><ListId>R1QW361FQPOEGM</ListId><ListName>bing281 : Science Fiction and Fantasy Books and Series</ListName></ListmaniaList><ListmaniaList><ListId>RIY0DQ7BK76XR</ListId><ListName>Mike's good reads</ListName></ListmaniaList><ListmaniaList><ListId>RI02AQN4CCZP9</ListId><ListName>Canonical Science Fiction</ListName></ListmaniaList></ListmaniaLists></Item></Items></ItemLookupResponse>
      HERE
    end

    context 'ISBN lookup' do
      before(:all) do
        @bad_book_isbn_xml = <<-HERE
          <?xml version="1.0" ?><ItemLookupResponse xmlns="http://webservices.amazon.com/AWSECommerceService/2008-10-06"><OperationRequest><HTTPHeaders><Header Name="UserAgent" Value="libwww-perl/5.820"></Header></HTTPHeaders><RequestId>fbccd2f4-d0d0-4126-8665-6c70eefe8972</RequestId><Arguments><Argument Name="Operation" Value="ItemLookup"></Argument><Argument Name="Service" Value="AWSECommerceService"></Argument><Argument Name="ItemId" Value="1111111111"></Argument><Argument Name="IdType" Value="ISBN"></Argument><Argument Name="AWSAccessKeyId" Value="1A190VPNHQTT4FWT25R2"></Argument><Argument Name="Timestamp" Value="2009-10-12T06:06:02Z"></Argument><Argument Name="Signature" Value="DwiK+OX8gqEaHB/VYknFPPlOfmTMHrIXAr4kuO5wfGQ="></Argument><Argument Name="ResponseGroup" Value="Large"></Argument><Argument Name="SearchIndex" Value="Books"></Argument><Argument Name="Version" Value="2009-01-01"></Argument></Arguments><RequestProcessingTime>0.1093970000000000</RequestProcessingTime></OperationRequest><Items><Request><IsValid>True</IsValid><ItemLookupRequest><Condition>New</Condition><DeliveryMethod>Ship</DeliveryMethod><IdType>ISBN</IdType><MerchantId>Amazon</MerchantId><OfferPage>1</OfferPage><ItemId>1111111111</ItemId><ResponseGroup>Large</ResponseGroup><ReviewPage>1</ReviewPage><ReviewSort>-SubmissionDate</ReviewSort><SearchIndex>Books</SearchIndex><VariationPage>All</VariationPage></ItemLookupRequest><Errors><Error><Code>AWS.InvalidParameterValue</Code><Message>1111111111 is not a valid value for ItemId. Please change this value and retry your request.</Message></Error></Errors></Request></Items></ItemLookupResponse>
        HERE

      end

      it 'should return an info hash given a good ISBN' do
        Amazon::Ecs.should_receive(:item_lookup).with(
          'good',
          {
            :search_index   => 'Books',
            :id_type        => 'ISBN',
            :response_group => 'Large'
          }
        ).and_return(Amazon::Ecs::Response.new(@good_book_xml))
        a = AmazonProductAdvertising.new

        response = a.lookup_book_edition_by_isbn('good')
        a.has_error?.should be_false
        response.should_not be_nil
        response.should == {
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
          :height_units    => 'hundredths-miles',
          :length          => '820',
          :length_units    => 'hundredths-miles',
          :width           => '520',
          :width_units     => 'hundredths-miles',
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

      it 'should return a nil response, and have the error given a bad ISBN' do
        Amazon::Ecs.should_receive(:item_lookup).with(
          'bad',
          {
            :search_index   => 'Books',
            :id_type        => 'ISBN',
            :response_group => 'Large'
          }
        ).and_return(Amazon::Ecs::Response.new(@bad_book_isbn_xml))
        a = AmazonProductAdvertising.new

        response = a.lookup_book_edition_by_isbn('bad')
        a.has_error?.should be_true
        a.error.should == '1111111111 is not a valid value for ItemId. Please change this value and retry your request.'
        response.should be_nil
      end
    end

    context 'UPC lookup' do
      before(:all) do
        @bad_book_upc_xml = <<-HERE
          <?xml version="1.0" ?><ItemLookupResponse xmlns="http://webservices.amazon.com/AWSECommerceService/2008-10-06"><OperationRequest><HTTPHeaders><Header Name="UserAgent" Value="libwww-perl/5.820"></Header></HTTPHeaders><RequestId>3f45f8ea-634a-4e0e-ba66-274c1702f49e</RequestId><Arguments><Argument Name="Operation" Value="ItemLookup"></Argument><Argument Name="Service" Value="AWSECommerceService"></Argument><Argument Name="Signature" Value="/XhzqH0WQZRUkCSHewutr4TgugYMPoJgvWHAsgJ8qp8="></Argument><Argument Name="Version" Value="2009-01-01"></Argument><Argument Name="ItemId" Value="111111111111"></Argument><Argument Name="IdType" Value="UPC"></Argument><Argument Name="AWSAccessKeyId" Value="1A190VPNHQTT4FWT25R2"></Argument><Argument Name="Timestamp" Value="2009-10-13T05:19:24Z"></Argument><Argument Name="ResponseGroup" Value="Large"></Argument><Argument Name="SearchIndex" Value="Books"></Argument></Arguments><RequestProcessingTime>0.0264580000000000</RequestProcessingTime></OperationRequest><Items><Request><IsValid>True</IsValid><ItemLookupRequest><Condition>New</Condition><DeliveryMethod>Ship</DeliveryMethod><IdType>UPC</IdType><MerchantId>Amazon</MerchantId><OfferPage>1</OfferPage><ItemId>111111111111</ItemId><ResponseGroup>Large</ResponseGroup><ReviewPage>1</ReviewPage><ReviewSort>-SubmissionDate</ReviewSort><SearchIndex>Books</SearchIndex><VariationPage>All</VariationPage></ItemLookupRequest><Errors><Error><Code>AWS.InvalidParameterValue</Code><Message>111111111111 is not a valid value for ItemId. Please change this value and retry your request.</Message></Error></Errors></Request></Items></ItemLookupResponse>
        HERE
      end

      it 'should return an info hash given a good UPC' do
        Amazon::Ecs.should_receive(:item_lookup).with(
          'good',
          {
            :search_index   => 'Books',
            :id_type        => 'UPC',
            :response_group => 'Large'
          }
        ).and_return(Amazon::Ecs::Response.new(@good_book_xml))
        a = AmazonProductAdvertising.new

        response = a.lookup_book_edition_by_upc('good')
        a.has_error?.should be_false
        response.should_not be_nil
        response.should == {
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
          :height_units    => 'hundredths-miles',
          :length          => '820',
          :length_units    => 'hundredths-miles',
          :width           => '520',
          :width_units     => 'hundredths-miles',
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

      it 'should return a nil response, and have the error given a bad UPC' do
        Amazon::Ecs.should_receive(:item_lookup).with(
          'bad',
          {
            :search_index   => 'Books',
            :id_type        => 'UPC',
            :response_group => 'Large'
          }
        ).and_return(Amazon::Ecs::Response.new(@bad_book_upc_xml))
        a = AmazonProductAdvertising.new

        response = a.lookup_book_edition_by_upc('bad')
        a.has_error?.should be_true
        a.error.should == '111111111111 is not a valid value for ItemId. Please change this value and retry your request.'
        response.should be_nil
      end
    end
  end
end
