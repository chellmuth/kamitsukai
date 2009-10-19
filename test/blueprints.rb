require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.binding(:unique => false)       { rand(2) == 0 ? 'Hard cover' : 'Soft cover'                     }
Sham.dewey_decimal(:unique => false) { sprintf("%03d.%02d", (000..999).to_a.rand, (00..99).to_a.rand) }

Sham.define do
  asin              { |index| sprintf("A%013d", index)                                         }
  body              { Faker::Lorem.paragraphs(3).join("\n\n")                                  }
  company           { Faker::Company.name                                                      }
  date              { Date.civil((2005..2009).to_a.rand, (1..12).to_a.rand, (1..28).to_a.rand) }
  ean               { |index| sprintf("%013d", index)                                          }
  email             { Faker::Internet.email                                                    }
  isbn              { |index| sprintf("%013d", index)                                          }
  name              { Faker::Name.name                                                         }
  password          { Faker::Lorem.words(rand(5)+1).join(' ')                                  }
  password_salt     { Authlogic::Random.hex_token                                              }
  persistence_token { Authlogic::Random.hex_token                                              }
  phone             { Faker::PhoneNumber.phone_number                                          }
  title             { Faker::Lorem.words(5).join(' ')                                          }
  username          { Faker::Internet.user_name                                                }
  web_page          { 'http://' + Faker::Internet.domain_name                                  }
end

User.blueprint do
  username
  email
  password
  password_confirmation { self.password }
  #
  crypted_password      { Authlogic::CryptoProviders::Sha512.encrypt(self.password + self.password_salt) }
  password_salt
  persistence_token
end

Book.blueprint do
  title
end

BookEdition.blueprint do
  book
  isbn
  ean
  asin
  binding
  dewey_decimal
  publisher       { Sham.company   }
  published       { Sham.date      }
  released        { Sham.date      }
  studio          { Sham.company   }
  pages           { rand(1000) + 1 }
  height          { rand(20) + 1   }
  height_units    { 'inches'       }
  length          { rand(20) + 1   }
  length_units    { 'inches'       }
  width           { rand(20) + 1   }
  width_units     { 'inches'       }
  detail_page_url { Sham.web_page  }
end

LentBook.blueprint do
  book_editions_user { BookEditionsUser.make }
  lent_to_user       { User.make             }
  due_at             { Sham.date             }
end

Setting.blueprint do
  key   { Faker::Lorem.words(rand(5)+1).join('_')  }
  value { Faker::Lorem.words(rand(10)+1).join(' ') }
end

AmazonImage.blueprint do
  url          { Sham.web_page         }
  height       { rand(3000)+1          }
  height_units { Faker::Lorem.words(1) }
  width        { rand(3000)+1          }
  width_units  { self.height_units     }
end
