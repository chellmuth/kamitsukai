# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_kamitsukai_session',
  :secret      => 'f51f7718aa7e5acc76d17a871f85499427b18895b55396a495b765d557dbf6c6966474fe4b1570334612ec853278503db03240cc2dc08b03312e828d49e9b46a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
