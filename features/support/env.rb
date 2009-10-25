# IMPORTANT: This file was generated by Cucumber 0.4.2
# Edit at your own peril - it's recommended to regenerate this file
# in the future when you upgrade to a newer version of Cucumber.
# Consider adding your own code to a new file instead of editing this one.

# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'

# If you set this to false, any error raised from within your app will bubble 
# up to your step definition and out to cucumber unless you catch it somewhere
# on the way. You can make Rails rescue errors and render error pages on a
# per-scenario basis by tagging a scenario or feature with the @allow-rescue tag.
#
# If you set this to true, Rails will rescue all errors and render error
# pages, more or less in the same way your application would behave in the
# default production environment. It's not recommended to do this for all
# of your scenarios, as this makes it hard to discover errors in your application.
ActionController::Base.allow_rescue = false

require 'cucumber'
# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'
require 'cucumber/webrat/element_locator' # Lets you do table.diff!(element_at('#my_table_or_dl_or_ul_or_ol').to_table)
require 'cucumber/rails/rspec'

require 'webrat'
require 'webrat/core/matchers' 
Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end

require 'database_cleaner'
require 'database_cleaner/cucumber'
Cucumber::Rails::World.use_transactional_fixtures = false
DatabaseCleaner.strategy = (ENV['SELENIUM'] == 'true') ? :truncation : :transaction
