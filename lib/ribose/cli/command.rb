require "ribose/cli/rcfile"
require "ribose/cli/commands/space"
require "ribose/cli/commands/file"
require "ribose/cli/commands/conversation"

module Ribose
  module CLI
    class Command < Thor
      desc "space", "List, Add or Remove User Space"
      subcommand :space, Ribose::CLI::Commands::Space

      desc "file", "List, Add or Remove Files"
      subcommand :file, Ribose::CLI::Commands::File

      desc "conversation", "List, Add or Remove Conversation"
      subcommand :conversation, Ribose::CLI::Commands::Conversation

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
