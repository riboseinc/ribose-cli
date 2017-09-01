module Ribose
  module CLI
    module Commands
      class File < Thor
        desc "list", "Listing the files for a space"
        option :format, aliases: "-f", desc: "Output format, eg: json"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def list
          say(build_output(list_files(options), options))
        end

        private

        def list_files(attributes)
          @files ||= Ribose::SpaceFile.all(attributes[:space_id])
        end

        def build_output(files, options)
          json_view(files, options) || table_view(files)
        end

        def json_view(files, options)
          if options[:format] == "json"
            files.map(&:to_h).to_json
          end
        end

        def table_rows(files)
          files.map { |file| [file.id, file.name, file.version] }
        end

        def table_view(files)
          Ribose::CLI::Util.list(
            headings: ["ID", "Name", "Versions"], rows: table_rows(files),
          )
        end
      end
    end
  end
end
