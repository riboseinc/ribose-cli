require "spec_helper"

RSpec.describe "Space Conversation" do
  describe "Listing conversations" do
    it "retrieves the list of conversations" do
      command = %w(conversation list --space-id 123456789 --format json)

      stub_ribose_space_conversation_list(123456789)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/"name":"Sample conversation"/)
      expect(output).to match(/"id":"741ebd0f-0959-42c5-b7d3-7749666d2f5f"/)
    end
  end
end
