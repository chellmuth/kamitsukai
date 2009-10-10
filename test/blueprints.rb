require 'machinist/active_record'
require 'sham'

Sham.define do
  asin              { |index| sprintf("A%013d", index)                                         }
  binding           { rand(2) == 0 ? "Hard cover" : "Soft cover"                               }
  body              { Faker::Lorem.paragraphs(3).join("\n\n")                                  }
  company           { Faker::Company.name                                                      }
  date              { Date.civil((2005..2009).to_a.rand, (1..12).to_a.rand, (1..28).to_a.rand) }
  dewey_decimal     { sprintf("%03d.%02d", (000..999).to_a.rand, (00..99).to_a.rand)           }
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
  book                            { Book.make         }
  isbn
  ean
  asin
  binding(:unique => false)
  dewey_decimal(:unique => false)
  publisher                       { Sham.company      }
  published                       { Sham.date         }
  released                        { Sham.date         }
  studio                          { Sham.company      }
  pages                           { rand(1000) + 1    }
  height                          { rand(20) + 1      }
  height_units(:unique => false)  { 'inches'          }
  length                          { rand(20) + 1      }
  length_units(:unique => false)  { 'inches'          }
  width                           { rand(20) + 1      }
  width_units(:unique => false)   { 'inches'          }
  detail_page_url                 { Sham.web_page     }
end

BookEditionsUsers.blueprint do
end

LentBook.blueprint do
  book_editions_user { BookEditionsUsers.make }
  user               { User.make              }
  due_at             { Sham.date              }
end
