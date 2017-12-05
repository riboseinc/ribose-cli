module Ribose
  module CLI
    module Commands
      class Note < Thor
        desc "list", "Listing notes for a user space"
        option :format, aliases: "-f", desc: "Output format, eg: json"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def list
          say(build_output(list_notes(options), options))
        end

        private

        def list_notes(attributes)
          @notes ||= Ribose::Wiki.all(attributes[:space_id])
        end

        def build_output(notes, options)
          json_view(notes, options) || table_view(notes)
        end

        def json_view(notes, options)
          if options[:format] == "json"
            notes.map(&:to_h).to_json
          end
        end

        def table_rows(notes)
          notes.map { |note| [note.id, note.name, note.revision] }
        end

        def table_view(notes)
          Ribose::CLI::Util.list(
            headings: ["ID", "Name", "Revisions"], rows: table_rows(notes),
          )
        end
      end
    end
  end
end
