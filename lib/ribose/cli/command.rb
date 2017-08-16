require "ribose/cli/commands/space"

module Ribose
  module CLI
    class Command < Thor
      desc "version", "The current active version"
      def version
        say(Ribose::CLI::VERSION)
      end

      desc "space", "List, Add or Remove User Space"
      subcommand :space, Ribose::CLI::Commands::Space
    end
  end
end
