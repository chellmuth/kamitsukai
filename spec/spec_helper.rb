ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'
require File.expand_path(File.join(File.dirname(__FILE__),'blueprints.rb'))
require 'authlogic/test_case'

# Uncomment the next line to use webrat's matchers
#require 'webrat/integrations/rspec-rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:all) do
    Sham.reset(:before_all)
  end

  config.before(:each) do
    activate_authlogic
    DatabaseCleaner.start
    Sham.reset(:before_each)
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def login(user_info=nil)
  user = User.make(user_info)
  assert UserSession.create(user)
  user
end

def logout
  session = UserSession.find
  session.destroy unless session.nil?
end
