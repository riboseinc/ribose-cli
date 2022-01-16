require "webmock/rspec"
require "ribose/cli"
require "ribose/rspec"

Dir["./spec/support/**/*.rb"].sort.each { |file| require file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
  config.include Ribose::ConsoleHelper

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before :all do
    Ribose.configure do |ribose_config|
      ribose_config.api_host = ENV["RIBOSE_API_HOST"] || "www.ribose.com"
      ribose_config.user_email = ENV["RIBOSE_USER_EMAIL"] || "user@ribose.com"
      ribose_config.user_password = ENV["RIBOSE_USER_PASSWORD"] || "SECRET_PASS"

      ribose_config.client = Ribose::Client.new
    end
  end
end
