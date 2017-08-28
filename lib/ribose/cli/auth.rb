require "ribose"
require "ribose/cli/rcfile"

unless Ribose.configuration.api_token
  Ribose.configure do |config|
    config.api_token = Ribose::CLI::RCFile.api_token
    config.user_email = Ribose::CLI::RCFile.user_email
  end
end
