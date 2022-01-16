require "ribose"
require "ribose/cli/rcfile"

unless Ribose.configuration.user_password
  Ribose.configure do |config|
    config.api_host = Ribose::CLI::RCFile.api_host
    config.user_email = Ribose::CLI::RCFile.user_email
    config.user_password = Ribose::CLI::RCFile.user_password
  end
end
