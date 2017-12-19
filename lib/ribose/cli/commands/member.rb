module Ribose
  module CLI
    module Commands
      class Member < Commands::Base
        desc "list", "List space members"
        option :format, aliases: "-f", desc: "Output format, eg: json"
        option :space_id, required: true, alias: "-s", desc: "The Space UUID"

        def list
          say(build_output(Ribose::Member.all(options[:space_id]), options))
        end

        private

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
