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

        desc "add", "Add a new note to a user space"
        option :title, required: true, desc: "The title for the note"
        option :tag_list, aliases: "-t", desc: "Note tags, separated by commas"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def add
          note = create_note(options)
          say("Note has been posted added! Id: " + note.id.to_s)
        end

        desc "remove", "Removes a note from a space"
        option :note_id, required: true, aliases: "-n", desc: "The Note UUID"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def remove
          remove_note(options)
          say("The note has been removed!")
        rescue
          say("Could not remove the specified note")
        end

        private

        def list_notes(attributes)
          @notes ||= Ribose::Wiki.all(attributes[:space_id])
        end

        def create_note(attributes)
          Ribose::Wiki.create(
            attributes[:space_id],
            name: attributes[:title],
            tag_list: attributes[:tag_list] || "",
          )
        end

        def remove_note(attributes)
          Ribose::Wiki.delete(attributes[:space_id], attributes[:note_id])
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
