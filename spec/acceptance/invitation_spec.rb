require "spec_helper"

RSpec.describe "Space Invitation" do
  describe "list" do
    it "retrieves the list of space invitations" do
      command = %w(invitation list --space-id 1234)

      stub_ribose_space_invitation_lis_api
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/ID    | Inviter    | Type/)
      expect(output).to match(/Doe | Invitation::ToSpace | The CLI Space/)
    end
  end
end
