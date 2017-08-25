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
    end
  end
end
