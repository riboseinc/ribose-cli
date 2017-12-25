module Ribose
  module CLI
    module Commands
      class JoinSpace < Commands::Base
        desc "list", "List join space requests"
        option :query, type: :hash, desc: "Query parameters as hash"
        option :format, aliases: "-f", desc: "Output format, eg: json"

        def list
          say(build_output(Ribose::JoinSpaceRequest.all(options), options))
        end

        desc "show", "Fetch a join space request"
        option :format, aliases: "-f", desc: "Output format, eg: json"
        option :request_id, required: true, aliases: "-r", desc: "Request UUID"

        def show
          join_space = Ribose::JoinSpaceRequest.fetch(options[:request_id])
          say(build_resource_output(join_space, options))
        end

        desc "add", "Create a join space request"
        option :type, aliases: "-t", desc: "The join request type"
        option :state, desc: "The state for the join space request"
        option :message, aliases: "-m", desc: "The join request message"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def add
          create_join_request(options)
          say("Join space request has been sent successfully!")
        rescue Ribose::UnprocessableEntity
          say("Something went wrong! Please check required attributes")
        end

        desc "accept", "Accept a join space request"
        option :request_id, required: true, aliases: "-r", desc: "Request UUID"

        def accept
          Ribose::JoinSpaceRequest.accept(options[:request_id])
          say("Join space request has been accepted!")
        end

        desc "reject", "Reject a join space request"
        option :request_id, required: true, aliases: "-r", desc: "Request UUID"

        def reject
          Ribose::JoinSpaceRequest.reject(options[:request_id])
          say("Join space request has been rejected!")
        end

        private

        def create_join_request(attributes)
          Ribose::JoinSpaceRequest.create(
            state: attributes[:state] || 0,
            space_id: attributes[:space_id],
            body: attributes[:message] || "",
            type: attributes[:type] || "Invitation::JoinSpaceRequest",
          )
        end

        def table_headers
          ["ID", "Inviter", "Type", "Space Name"]
        end

        def table_field_names
          %w(id email body state type)
        end

        def table_rows(requests)
          requests.map do |req|
            [req.id, req.inviter.name, req.type, req.space.name]
          end
        end
      end
    end
  end
end
