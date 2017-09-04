require "spec_helper"

RSpec.describe "Conversation Messages" do
  describe "listing messages" do
    it "retrieves the list of messages" do
      command = %w(message list -s 123456789 -c 123456789 --format json)

      stub_ribose_message_list(123456789, 123456789)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/"contents":"Welcome to Ribose Space"/)
      expect(output).to match(/"id":"eec38935-3070-4949-b217-878aa07db699"/)
    end
  end

  describe "Adding new message" do
    it "allows us to add message to a conversation" do
      command = %W(
        message add
        --space-id 123
        --message-body #{message.contents}
        --conversation-id #{message.conversation_id}
      )

      stub_ribose_message_create(123, message: message.to_h)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/Messge has been posted/)
      expect(output).to match(/Id: 9af4df9f-2a30-4d66-a925-efaf45057ae4/)
    end
  end

  def message
    @message ||= OpenStruct.new(
      contents: "Welcome to Ribose!",
      conversation_id: "987654321",
    )
  end

  def stub_ribose_message_create(sid, attributes)
    cid = attributes[:message][:conversation_id]
    message_path = "spaces/#{sid}/conversation/conversations/#{cid}/messages"

    stub_api_response(
      :post, message_path, data: attributes, filename: "message_created"
    )
  end
end