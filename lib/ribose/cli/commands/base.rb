module Ribose
  module CLI
    module Commands
      class Base < Thor
        private

        # Table Headers
        #
        # Listing resources in table view will invoke this method to
        # retrieve the list of headers, please override this in the
        # sub-class and fill it in with actual fields name.
        #
        def table_headers
          raise NotImplementedError
        end

        # Table Rows
        #
        # List resources in table view will invoke this method to build
        # each of the individual resource row, please override this with
        # an array that includes the value for headers.
        #
        def table_rows
          raise NotImplementedError
        end

        # Table field names
        #
        # Displaying a single resource in table view will invoke this
        # method to figure out field name and values for each of the
        # row in table, please override this with proper attributes
        #
        def table_field_names
          raise NotImplementedError
        end

        def build_output(resources, options)
          json_view(resources, options) || table_view(resources)
        end

        def build_resource_output(resource, options)
          resource_as_json(resource, options) || resource_as_table(resource)
        end

        def json_view(resources, options)
          if options[:format] == "json"
            resources.map(&:to_h).to_json
          end
        end

        def resource_as_json(resource, options)
          if options[:format] == "json"
            resource.to_h.to_json
          end
        end

        def table_view(resources)
          Ribose::CLI::Util.list(
            headings: table_headers, rows: table_rows(resources),
          )
        end

        def resource_as_table(resource)
          Ribose::CLI::Util.list(
            headings: ["Field", "Value"],
            rows: table_field_names.map { |key| [key, resource[key.to_s]] },
          )
        end

        def symbolize_keys(options_hash)
          Hash.new.tap do |hash|
            options_hash.each_key do |key|
              hash[(key.to_sym rescue key) || key] = options_hash.fetch(key)
            end
          end
        end
      end
    end
  end
end
