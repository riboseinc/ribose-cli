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

        private

        def list_conversations
          @conversations ||= Ribose::Conversation.all(options[:space_id])
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
