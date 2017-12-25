module Ribose
  module CLI
    module Commands
      class File < Commands::Base
        desc "list", "Listing the files for a space"
        option :format, aliases: "-f", desc: "Output format, eg: json"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def list
          say(build_output(list_files(options), options))
        end

        desc "show", "Details for a space file"
        option :file_id, required: true, desc: "The space file ID"
        option :format, aliases: "-f", desc: "Output format, eg: json"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def show
          file = Ribose::SpaceFile.fetch(options[:space_id], options[:file_id])
          say(build_resource_output(file, options))
        end

        desc "add", "Adding a new fille to a space"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"
        option :description, aliases: "-d", desc: "The file upload description"
        option :tag_list, aliases: "-t", desc: "File tags, separated by commas"

        def add(file)
          file_upload = create_upload(file, options)

          if file_upload.id
            say("#{file_upload.name} added to your space!")
          end
        end

        private

        def list_files(attributes)
          @files ||= Ribose::SpaceFile.all(attributes[:space_id])
        end

        def create_upload(file, attributes = {})
          Ribose::SpaceFile.create(
            attributes[:space_id],
            file: file,
            tag_list: attributes[:tag_list],
            description: attributes[:description],
          )
        end

        def table_headers
          ["ID", "Name", "Versions"]
        end

        def table_field_names
          %w(id name author content_type content_size version)
        end

        def table_rows(files)
          files.map { |file| [file.id, file.name, file.version] }
        end
      end
    end
  end
end
