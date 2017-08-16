module Ribose
  module CLI
    module Commands
      class Space < Thor
        desc "list", "List user spaces"
        def list
          say(table_view(list_user_spaces))
        end

        private

        def list_user_spaces
          @user_spaces ||= Ribose::Space.all
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
