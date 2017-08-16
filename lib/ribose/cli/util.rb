require "terminal-table"

module Ribose
  module CLI
    module Util
      def self.list(headings:, rows:, table_wdith: 80)
        Terminal::Table.new do |table|
          table.headings = headings
          table.style = { width: table_wdith }
          table.rows = rows
        end
      end
    end
  end
end
