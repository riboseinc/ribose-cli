module Ribose
  module CLI
    module Commands
      class Space < Thor
        desc "list", "List user spaces"
        option :format, aliases: "-f", desc: "Output format, eg: json"
        def list
          say(build_output(list_user_spaces, options))
        end

        private

        def list_user_spaces
          @user_spaces ||= Ribose::Space.all
        end

        def build_output(spaces, options)
          json_view(spaces, options) || table_view(spaces)
        end

        def json_view(spaces, options)
          if options[:format] == "json"
            spaces.map(&:to_h).to_json
          end
        end

        def table_rows(spaces)
          spaces.map { |space| [space.id, space.name, space.active ] }
        end

        def table_view(spaces)
          Ribose::CLI::Util.list(
            headings: ["ID", "Name", "Active?"], rows: table_rows(spaces),
          )
        end
      end
    end
  end
end
