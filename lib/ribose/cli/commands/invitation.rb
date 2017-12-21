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

        desc "update", "Update a space invitation"
        option :role_id, aliases: "-r", desc: "The Role ID"
        option :state, aliases: "-s", desc: "New state for invitation"
        option :invitation_id, required: true, desc: "Invitation UUID"

        def update
          update_invitation(options)
          say("Space invitation has been updated!")
        rescue Ribose::UnprocessableEntity
          say("Something went wrong! Please check required attributes")
        end

        desc "accept", "Accept a space invitation"
        option :invitation_id, required: true, desc: "Invitation UUID"

        def accept
          Ribose::SpaceInvitation.accept(options[:invitation_id])
          say("Space invitation has been accepted!")
        end

        desc "remove", "Remove a space invitation"
        option :invitation_id, required: true, desc: "Invitation UUID"

        def remove
          Ribose::SpaceInvitation.cancel(options[:invitation_id])
          say("Space invitation has been removed!")
        rescue Ribose::Forbidden
          say("Could not remove the specified invitation")
        end

        private

        def update_invitation(attributes)
          Ribose::SpaceInvitation.update(
            attributes.delete(:invitation_id), attributes
          )
        end

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
