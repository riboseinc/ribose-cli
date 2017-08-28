require "ribose/cli/rcfile"
require "ribose/cli/commands/space"

module Ribose
  module CLI
    class Command < Thor
      desc "space", "List, Add or Remove User Space"
      subcommand :space, Ribose::CLI::Commands::Space

      desc "config", "Configure API Key and User Email"
      option :token, required: true, desc: "Your API Token for Ribose"
      option :email, required: true, desc: "Your email address for Ribose"

      def config
        Ribose::CLI::RCFile.set(
          email: options[:email], token: options[:token],
        )
      end

      desc "version", "The current active version"
      def version
        say(Ribose::CLI::VERSION)
      end
    end
  end
end