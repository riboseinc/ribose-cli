module Ribose
  module CLI
    module Commands
      class Member < Commands::Base
        desc "list", "List space members"
        option :format, aliases: "-f", desc: "Output format, eg: json"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def list
          say(build_output(Ribose::Member.all(options[:space_id]), options))
        end

        desc "add", "Add a new space member"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"
        option :user_id, aliases: "-u", type: :hash, desc: "Invitee's IDS"
        option :email, aliases: "-e", type: :hash, desc: "Invitee's emails"
        option :message, aliases: "-m", desc: "Space invitation message"

        def add
          add_member_to_space(options)
          say("Invitation has been sent successfully!")
        rescue Ribose::UnprocessableEntity
          say("Something went wrong! Please check required attributes")
        end

        desc "update", "Update existing member details"
        option :role_id, required: true, aliases: "-r", desc: "The role id"
        option :member_id, required: true, aliases: "-m", desc: "Member UUID"
        option :space_id, required: true, aliases: "-s", desc: "The Space UUID"

        def update
          update_member_role(options)
          say("Member has been updated with new role!")
        rescue Ribose::UnprocessableEntity
          say("Something went wrong! Please check required attributes")
        end

        private

        def add_member_to_space(attributes)
          Ribose::SpaceInvitation.mass_create(
            attributes[:space_id],
            body: attributes[:message] || "",
            emails: (attributes[:email] || {}).keys,
            user_ids: (attributes[:user_id] || {}).keys,
            role_ids: (attributes[:email] || {}).merge(attributes[:user_id]),
          )
        end

        def update_member_role(attributes)
          Ribose::MemberRole.assign(
            attributes[:space_id], attributes[:member_id], attributes[:role_id]
          )
        end

        def table_headers
          ["ID", "Name", "Role Name"]
        end

        def table_rows(members)
          members.map do |member|
            [member.user_id, member.user.name, member.role_name_in_space]
          end
        end
      end
    end
  end
end
