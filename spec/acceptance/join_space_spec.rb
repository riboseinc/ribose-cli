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

  describe "show" do
    it "retrieves the details for a join reqeust" do
      command = %w(join-space show --request-id 2468)

      stub_ribose_join_space_request_fetch_api(2468)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/state | 0/)
      expect(output).to match(/id    | 123456789/)
      expect(output).to match(/type  | Invitation::ToSpace/)
    end
  end

  describe "add" do
    it "creates a new join space request" do
      command = %w(join-space add --space-id 1234)

      stub_join_space_request_api_call(1234)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/Join space request has been sent successfully!/)
    end
  end

  describe "accept" do
    it "allows a user to accept a join space request" do
      command = %w(join-space accept --request-id 2468)

      stub_ribose_join_space_request_update(2468, state: 1)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/Join space request has been accepted!/)
    end
  end

  describe "reject" do
    it "allows a user to reject a join space request" do
      command = %w(join-space reject --request-id 2468)

      stub_ribose_join_space_request_update(2468, state: 2)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/Join space request has been rejected!/)
    end
  end

  # This prepares the request body to match with wbmock's expected
  # one to successfully stub  `POST /invitations/join_space_request`
  #
  def stub_join_space_request_api_call(space_id, state: 0, body: "")
    stub_ribose_join_space_request_create_api(
      state: state,
      body: body,
      type: "Invitation::JoinSpaceRequest",
      space_id: space_id.to_s,
    )
  end
end
