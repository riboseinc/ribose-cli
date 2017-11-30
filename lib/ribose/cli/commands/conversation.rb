module Ribose
  module CLI
    module Commands
      class Conversation < Thor
        desc "list", "Listing A Space Conversations"
        option :format, aliases: "-f", desc: "Output format, eg: json"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def list
          say(build_output(list_conversations, options))
        end

        desc "add", "Add a new conversation to Space"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"
        option :title, required: true, desc: "The title for the conversation"
        option :tags, aliases: "-t", desc: "The tags for the conversation"

        def add
          conversation = create_conversation(options)
          say("New Conversation created! Id: " + conversation.id)
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

        def list_conversations
          @conversations ||= Ribose::Conversation.all(options[:space_id])
        end

        def create_conversation(options)
          Ribose::Conversation.create(
            options[:space_id], name: options[:title], tag_list: options[:tags]
          )
        end

        def remove_conversation(options)
          Ribose::Conversation.destroy(
            space_id: options[:space_id],
            conversation_id: options[:conversation_id],
          )
        end

        def build_output(conversations, options)
          json_view(conversations, options) || table_view(conversations)
        end

        def json_view(conversations, options)
          if options[:format] == "json"
            conversations.map(&:to_h).to_json
          end
        end

        def table_rows(conversations)
          conversations.map { |conv| [conv.id, conv.name] }
        end

        def table_view(conversations)
          Ribose::CLI::Util.list(
            headings: ["ID", "Title"], rows: table_rows(conversations),
          )
        end
      end
    end
  end
end
