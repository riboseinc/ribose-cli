require "yaml"
require "singleton"

module Ribose
  module CLI
    class RCFile
      attr_reader :path, :data
      FILE_NAME = ".riboserc".freeze

      def initialize
        @path = build_rcfile_path
        @data = load_configuration
      end

      def set(email:, password:, token: nil, api_host: nil)
        data[:api_token] = token
        data[:user_email] = email
        data[:user_password] = password
        data[:api_host] = api_host

        write_api_details_to_file
      end

      def self.api_token
        new.data[:api_token]
      end

      def self.user_email
        new.data[:user_email]
      end

      def self.user_password
        new.data[:user_password]
      end

      def self.api_host
        ENV.fetch("RIBOSE_API_HOST", new.data[:api_host])
      end

      def self.set(email:, password:, token: nil, api_host: nil)
        new.set(token: token, email: email, password: password, api_host: api_host)
      end

      private

      def build_rcfile_path
        File.join(File.expand_path("~"), FILE_NAME)
      end

      def load_configuration
        YAML.load_file(path)
      rescue Errno::ENOENT
        default_configuration
      end

      def default_configuration
        { api_token: nil, user_email: nil }
      end

      def write_api_details_to_file
        File.open(path, File::RDWR | File::TRUNC | File::CREAT, 0o0600) do |rc|
          rc.write(data.to_yaml)
        end
      end
    end
  end
end
