require "spec_helper"

RSpec.describe "Join Space Request" do
  describe "list" do
    it "retrieves the list of join space requests" do
      command = %w(join-space list)

      stub_ribose_join_space_request_list_api
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/| ID    | Inviter    | Type/)
      expect(output).to match(/| 27743 | Jennie Doe | Invitation::ToSpace/)
    end
  end
end
