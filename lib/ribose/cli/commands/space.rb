module Ribose
  module CLI
    module Commands
      class Space < Commands::Base
        desc "list", "List user spaces"
        option :format, aliases: "-f", desc: "Output format, eg: json"

        def list
          say(build_output(list_user_spaces, options))
        end

        desc "add", "Add a new user space"
        option :access, desc: "The visiblity for the space"
        option :name, aliases: "-n", desc: "Name of the space"
        option :description, desc: "The description for space"
        option :category_id, desc: "The category for this space"

        def add
          space = create_space(options)
          say("New Space created! Id: " + space.id)
        end

        desc "remove", "Remove an existing space"
        option :space_id, required: true, desc: "The Space UUID"
        option :confirmation, required: true, desc: "The confirmation"

        def remove
          remove_space(options)
          say("The Sapce has been removed!")
        rescue
          say("Please provide a valid Space UUID")
        end

        private

        def list_user_spaces
          @user_spaces ||= Ribose::Space.all
        end

        def create_space(attributes)
          Ribose::Space.create(
            name: attributes[:name],
            access: attributes[:access] || "open",
            description: attributes[:description],
            category_id: attributes[:category_id],
          )
        end

        def remove_space(attributes)
          Ribose::Space.remove(
            attributes[:space_id],
            password_confirmation: attributes[:confirmation],
          )
        end

        def table_headers
          ["ID", "Name", "Active?"]
        end

        def table_rows(spaces)
          spaces.map { |space| [space.id, space.name, space.active ] }
        end
      end
    end
  end
end
