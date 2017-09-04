require "terminal-table"

module Ribose
  module CLI
    module Util
      def self.list(headings:, rows:)
        Terminal::Table.new do |table|
          table.headings = headings
          table.rows = rows
        end
      end

      def self.truncate(content, length = 50)
        if content && content.length > length
          content = content[0..length] + "..."
        end

        content
      end
    end
  end
end
