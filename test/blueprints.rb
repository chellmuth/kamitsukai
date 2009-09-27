require 'machinist/active_record'
require 'sham'

Sham.define do
  body              { Faker::Lorem.paragraphs(3).join("\n\n")       }
  crypted_password  { Authlogic::CryptoProviders::Sha512.encrypt(p) }
  email             { Faker::Internet.email                         }
  name              { Faker::Name.name                              }
  phone             { Faker::PhoneNumber.phone_number               }
  title             { Faker::Lorem.words(5).join(' ')               }
  username          { Faker::Internet.user_name                     }
  web_page          { 'http://' + Faker::Internet.domain_name       }
  password_salt     { Authlogic::Random.hex_token                   }
  persistence_token { Authlogic::Random.hex_token                   }
  password          { Faker::Lorem.words(rand(5)+1).join(' ')       }
end

User.blueprint do
  username
  email
  password
  password_confirmation { self.password }
  #
  crypted_password      { Sham.crypted_password(self.password + self.password_salt) }
  password_salt
  persistence_token
end
