module Ribose
  module CLI
    module Commands
      class Invitation < Commands::Base
        desc "list", "List space invitations"
        option :space_id, aliases: "-s", desc: "The Space UUID"
        option :query, type: :hash, desc: "Query parameters as hash"
        option :format, aliases: "-f", desc: "Output format, eg: json"

        def list
          say(build_output(Ribose::SpaceInvitation.all(options), options))
        end

        private

        def table_headers
          ["ID", "Inviter", "Type", "Space Name"]
        end

        def table_rows(invitations)
          invitations.map do |invt|
            [invt.id, invt.inviter.name, invt.type, invt.space.name]
          end
        end
      end
    end
  end
end
