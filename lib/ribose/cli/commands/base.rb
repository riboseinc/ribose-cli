module Ribose
  module CLI
    module Commands
      class Base < Thor
        private

        def table_headers
          raise NotImplementedError
        end

        def table_rows
          raise NotImplementedError
        end

        def build_output(resources, options)
          json_view(resources, options) || table_view(resources)
        end

        def json_view(resources, options)
          if options[:format] == "json"
            resources.map(&:to_h).to_json
          end
        end

        def table_view(resources)
          Ribose::CLI::Util.list(
            headings: table_headers, rows: table_rows(resources),
          )
        end
      end
    end
  end
end
