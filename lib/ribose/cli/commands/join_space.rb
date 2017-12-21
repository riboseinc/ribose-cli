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

        private

        def table_headers
          ["ID", "Inviter", "Type", "Space Name"]
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
