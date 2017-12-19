require "spec_helper"

RSpec.describe "Space Member" do
  describe "list" do
    it "retrieves the list of space members" do
      command = %w(member list --space-id 123456)

      stub_ribose_space_member_list(123456)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/| Name     | Role Name/)
      expect(output).to match(/8332-fcdaecb13e34 | John Doe | Administrator/)
    end
  end
end
