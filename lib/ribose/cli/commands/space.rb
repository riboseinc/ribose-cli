module Ribose
  module CLI
    module Commands
      class Space < Commands::Base
        desc "list", "List user spaces"
        option :format, aliases: "-f", desc: "Output format, eg: json"

        def list
          say(build_output(list_user_spaces, options))
        end

        desc "show", "Details for a space"
        option :space_id, aliases: "-s", description: "The Space UUID"
        option :format, aliases: "-f", desc: "Output format, eg: json"

        def show
          space = Ribose::Space.fetch(options[:space_id])
          say(build_resource_output(space, options))
        end

        desc "add", "Add a new user space"
        option :name, aliases: "-n", desc: "Name of the space"
        option :description, desc: "The description for space"
        option :category_id, desc: "The category for this space"
        option :access, default: "open", desc: "The visiblity for the space"

        def add
          space = Ribose::Space.create(symbolize_keys(options))
          say("New Space created! Id: " + space.id)
        end

        desc "update", "Update an existing space"
        option :space_id, required: true, desc: "The Space UUID"
        option :access, desc: "The visiblity for the space"
        option :name, aliases: "-n", desc: "Name of the space"
        option :description, desc: "The description for space"
        option :category_id, desc: "The category for this space"

        def update
          attributes = symbolize_keys(options)
          Ribose::Space.update(attributes.delete(:space_id), attributes)
          say("Your space has been updated!")
        rescue Ribose::UnprocessableEntity
          say("Something went wrong!, please check required attributes")
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

        # Single resource fields
        def table_field_names
          %w(id name visibility active members_count role_name)
        end
      end
    end
  end
end
