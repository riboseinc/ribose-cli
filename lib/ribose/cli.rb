require "thor"

require "ribose/cli/version"
require "ribose/cli/command"

module Ribose
  module CLI
    def self.start(arguments)
      Ribose::CLI::Command.start(arguments)
    end
  end
end
