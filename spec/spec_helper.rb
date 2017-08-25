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
end
