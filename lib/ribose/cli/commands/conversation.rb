module Ribose
  module CLI
    module Commands
      class Conversation < Commands::Base
        desc "list", "Listing A Space Conversations"
        option :format, aliases: "-f", desc: "Output format, eg: json"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def list
          say(build_output(list_conversations, options))
        end

        desc "show", "Show the details for a conversation"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"
        option :format, aliases: "-f", desc: "Output format, eg: json"

        option(
          :conversation_id,
          required: true,
          aliases: "-c",
          desc: "The Conversation UUID",
        )

        def show
          say(build_resource_output(conversation(options), options))
        end

        desc "add", "Add a new conversation to Space"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"
        option :title, required: true, desc: "The title for the conversation"
        option :tags, aliases: "-t", desc: "The tags for the conversation"

        def add
          conversation = create_conversation(options)
          say("New Conversation created! Id: " + conversation.id)
        end

        desc "update", "Updae an existing conversation"
        option :title, desc: "The title for the conversation"
        option :tags, aliases: "-t", desc: "The tags for the conversation"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"
        option(
          :conversation_id,
          required: true,
          aliases: "-c",
          desc: "The conversation UUID",
        )

        def update
          update_conversation(symbolize_keys(options))
          say("Your conversation has been updated!")
        rescue Ribose::UnprocessableEntity
          say("Something went wrong!, please check required attributes")
        end

        desc "remove", "Remove A Conversation from Space"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"
        option :conversation_id, required: true, aliases: "-c"

        def remove
          remove_conversation(options)
          say("The Conversation has been removed!")
        rescue
          say("Please provide a valid Conversation UUID")
        end

        private

        def conversation(attributes)
          @conversation ||= Ribose::Conversation.fetch(
            attributes[:space_id], attributes[:conversation_id]
          )
        end

        def list_conversations
          @conversations ||= Ribose::Conversation.all(options[:space_id])
        end

        def create_conversation(options)
          Ribose::Conversation.create(
            options[:space_id], name: options[:title], tag_list: options[:tags]
          )
        end

        def update_conversation(attributes)
          Ribose::Conversation.update(
            attributes.delete(:space_id),
            attributes.delete(:conversation_id),
            attributes,
          )
        end

        def remove_conversation(options)
          Ribose::Conversation.destroy(
            space_id: options[:space_id],
            conversation_id: options[:conversation_id],
          )
        end

        def table_headers
          ["ID", "Title"]
        end

        def table_field_names
          %w(id space_id name number_of_messages allow_comment)
        end

        def table_rows(conversations)
          conversations.map { |conv| [conv.id, conv.name] }
        end
      end
    end
  end
end
