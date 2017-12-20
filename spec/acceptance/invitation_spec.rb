require "spec_helper"

RSpec.describe "Space Invitation" do
  describe "list" do
    it "retrieves the list of space invitations" do
      command = %w(invitation list)

      stub_ribose_space_invitation_lis_api
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/ID    | Inviter    | Type/)
      expect(output).to match(/Doe | Invitation::ToSpace | The CLI Space/)
    end
  end

  describe "add" do
    it "sends a space invitation to a member" do
      command = %W(
        invitation add
        --space-id #{invitation.space_id}
        --user-id #{invitation.id1}:#{invitation.role}
        --email #{invitation.email1}:0 #{invitation.email2}:1
        --message #{invitation.message}
      )

      stub_ribose_space_invitation_mass_create(
        invitation.space_id, build_attr_in_stub_format(invitation)
      )

      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/Invitation has been sent successfully!/)
    end
  end

  def invitation
    @invitation ||= OpenStruct.new(
      id1: "123456",
      id2: "567890",
      role: "123456",
      space_id: "123456789",
      email1: "invitee-one@example.com",
      email2: "invitee-two@example.com",
      message: "Your invitation message",
    )
  end

  # This might look compact, but the only purpose for this is to prepare
  # the attributes / sequence with the one webmock would be epxecting to
  # stub the api request successfully.
  #
  def build_attr_in_stub_format(invitation)
    {
      body: invitation.message,
      emails: [invitation.email1, invitation.email2],
      user_ids: [invitation.id1],
      role_ids: {
        "#{invitation.email1}": "0",
        "#{invitation.email2}": "1",
        "#{invitation.id1}": invitation.role,
      },
      space_id: invitation.space_id,
    }
  end
end
