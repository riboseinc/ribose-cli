module Ribose
  module CLI
    module Commands
      class Invitation < Commands::Base
        desc "list", "List space invitations"
        option :query, type: :hash, desc: "Query parameters as hash"
        option :format, aliases: "-f", desc: "Output format, eg: json"

        def list
          say(build_output(Ribose::SpaceInvitation.all(options), options))
        end

        desc "add", "Add a new space member"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"
        option :user_id, aliases: "-u", type: :hash, desc: "Invitee's IDS"
        option :email, aliases: "-e", type: :hash, desc: "Invitee's emails"
        option :message, aliases: "-m", desc: "Space invitation message"

        def add
          invoke(Member, :add)
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
