require "thor"
require "ribose"

require "ribose/cli/auth"
require "ribose/cli/util"
require "ribose/cli/version"
require "ribose/cli/command"

module Ribose
  module CLI
    def self.start(arguments)
      Ribose.configuration.debug_mode = true
      Ribose::CLI::Command.start(arguments)
    rescue Ribose::Unauthorized, Ribose::Errors::Forbidden
      Thor::Shell::Basic.new.say(
        "Invalid: Missing API Configuration\n\n" \
        "Ribose API Token & Email are required for any of the CLI operation\n" \
        "You can set your API Key using `ribose config --email email --password`",
      )
    end
  end

  # Temporary: The API Client will implement it
  module Errors
    class Forbidden < StandardError; end
  end
end
