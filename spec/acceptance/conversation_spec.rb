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

  describe "Retrieving a conversation" do
    it "retrieves the details for a conversation" do
      command = %w(conversation show --space-id 12345 --conversation-id 6789)

      stub_ribose_space_conversation_fetch_api(12345, 6789)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/number_of_messages | 1/)
      expect(output).to match(/name               | Trips to the Mars!/)
    end
  end

  describe "Adding a new conversations" do
    it "creates a new conversation into a user space" do
      command = %W(
        conversation add
        --title #{conversation.title}
        --space-id #{conversation.space_id}
        --tags #{conversation.tags}
      )

      stub__conversation_creation(conversation)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/New Conversation created!/)
      expect(output).to match(/Id: ee50bb3c-ed79-4efc-821a-64926f645bfb/)
    end
  end

  describe "Update an existing conversation" do
    it "updates details for an existing conversation" do
      command = %W(
        conversation update
        --conversation-id 123456789
        --space-id #{conversation.space_id}
        --title #{conversation.title}
        --tags #{conversation.tags}
      )

      stub_ribose_space_conversation_update_api(
        123_456_789, 123_456_789, conversation.to_h
      )

      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/Your conversation has been updated!/)
    end
  end

  describe "Remove a conversation" do
    it "removes a conversation from a speace" do
      command = %w(conversation remove -s 9876 --conversation-id 12345)

      stub_ribose_space_conversation_remove(9876, 12345)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/The Conversation has been removed!/)
    end
  end

  def conversation
    @conversation ||= OpenStruct.new(
      space_id: 123_456_789, title: "The Special Conversation", tags: "sample",
    )
  end

  def stub__conversation_creation(conversation)
    stub_ribose_space_conversation_create(
      conversation.space_id,
      name: conversation.title,
      tag_list: conversation.tags,
      space_id: conversation.space_id.to_s,
    )
  end
end
