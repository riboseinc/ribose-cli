module Ribose
  module CLI
    class Command < Thor
      desc "version", "The current active version"
      def version
        Thor::Shell::Basic.new.say(Ribose::CLI::VERSION)
      end
    end
  end
end
