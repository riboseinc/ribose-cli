require "ribose/cli/rcfile"
require "ribose/cli/commands/base"
require "ribose/cli/commands/space"
require "ribose/cli/commands/file"
require "ribose/cli/commands/conversation"
require "ribose/cli/commands/message"
require "ribose/cli/commands/note"
require "ribose/cli/commands/member"
require "ribose/cli/commands/invitation"
require "ribose/cli/commands/join_space"

module Ribose
  module CLI
    class Command < Thor
      desc "space", "List, Add or Remove User Space"
      subcommand :space, Ribose::CLI::Commands::Space

      desc "member", "List, Add or Remove Space Member"
      subcommand :member, Ribose::CLI::Commands::Member

      desc "note", "List, Add or Remove Space Note"
      subcommand :note, Ribose::CLI::Commands::Note

      desc "file", "List, Add or Remove Files"
      subcommand :file, Ribose::CLI::Commands::File

      desc "conversation", "List, Add or Remove Conversation"
      subcommand :conversation, Ribose::CLI::Commands::Conversation

      desc "message", "List, Add or Remove Message"
      subcommand :message, Ribose::CLI::Commands::Message

      desc "invitation", "Manage Space Invitations"
      subcommand :invitation, Ribose::CLI::Commands::Invitation

      desc "join-space", "Manage Join Space Request"
      subcommand :join_space, Ribose::CLI::Commands::JoinSpace

      desc "config", "Configure API Key and User Email"
      option :token, required: false, desc: "Your API Token for Ribose"
      option :email, required: true, desc: "Your email address for Ribose"
      option :password, required: true, desc: "Your API password for Ribose"
      option :api_host, required: true, desc: "API host, eg: www.ribose.com"

      def config
        Ribose::CLI::RCFile.set(
          token: options[:token],
          email: options[:email],
          password: options[:password],
          api_host: options[:api_host],
        )
      end

      desc "version", "The current active version"
      def version
        say(Ribose::CLI::VERSION)
      end
    end
  end
end
