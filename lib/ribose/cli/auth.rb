require "ribose"

unless Ribose.configuration.api_token
  Ribose.configure do |config|
    config.api_token = ENV["RIBOSE_API_TOKEN"]
    config.user_email = ENV["RIBOSE_USER_EMAIL"]
  end
end
