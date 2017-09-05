module Ribose
  module CLI
    module Commands
      class Message < Thor
        desc "list", "Listing Messages"
        option :conversation_id, aliases: "-c", required: true
        option :format, aliases: "-f", desc: "Output format, eg: json"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def list
          say(build_output(list_messages, options))
        end

        desc "add", "Add New Message to Conversation"
        option :message_body, required: true, aliases: "-b"
        option :conversation_id, aliases: "-c", required: true
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def add
          message = create_message(options)
          say("Messge has been posted! Id: " + message.id)
        end

        desc "edit", "Edit an existing Message"
        option :message_body, required: true, aliases: "-b"
        option :message_id, required: true, aliases: "-m"
        option :conversation_id, aliases: "-c", required: true
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def edit
          update_message(options)
          say("Messge has been updated!")
        end

        private

        def list_messages
          @messages ||= Ribose::Message.all(
            space_id: options[:space_id],
            conversation_id: options[:conversation_id],
          )
        end

        def create_message(options)
          Ribose::Message.create(
            space_id: options[:space_id],
            contents: options[:message_body],
            conversation_id: options[:conversation_id],
          )
        end

        def update_message(options)
          Ribose::Message.update(
            space_id: options[:space_id],
            message_id: options[:message_id],
            contents: options[:message_body],
            conversation_id: options[:conversation_id],
          )
        end

        def build_output(messages, options)
          json_view(messages, options) || table_view(messages)
        end

        def json_view(messages, options)
          if options[:format] == "json"
            messages.map(&:to_h).to_json
          end
        end

        def table_rows(messages)
          messages.map do |message|
            [message.id, message.user.name, sanitize(message.contents)]
          end
        end

        def sanitize(content, length = 30)
          content = content.to_s.gsub(/<\/?[^>]*>/, "")
          Ribose::CLI::Util.truncate(content, length)
        end

        def table_view(messages)
          Ribose::CLI::Util.list(
            headings: ["ID", "User", "Message"], rows: table_rows(messages),
          )
        end
      end
    end
  end
end
