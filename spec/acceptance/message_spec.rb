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
end
