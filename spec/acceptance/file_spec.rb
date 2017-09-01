require "spec_helper"

RSpec.describe "File Interface" do
  describe "listing files" do
    it "retrieves the list of files" do
      command = %w(file list --space-id 123456 --format json)

      stub_ribose_space_file_list(123456)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/"id":9896/)
      expect(output).to match(/"name":"sample-file.png"/)
    end
  end
end
