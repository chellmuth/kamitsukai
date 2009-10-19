ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require File.expand_path(File.dirname(__FILE__) + "/blueprints")
require 'authlogic/test_case'

class ActiveSupport::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Reset Sham
  setup { Sham.reset }

  # Add more helper methods to be used by all tests here...
  def assert_valid(record)
    assert record.valid?, record.errors.full_messages.join("\n")
  end

  def login(user_info=nil)
    user = User.make(user_info)
    assert UserSession.create(user)
    user
  end

  def logout
    session = UserSession.find
    session.destroy
  end
end

class ActionController::TestCase
  setup :activate_authlogic
end
