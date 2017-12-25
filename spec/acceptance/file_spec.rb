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

  describe "show" do
    it "retrieves the details for a file" do
      command = %w(file show --file-id 5678 --space-id 1234)

      stub_ribose_space_file_fetch_api(1234, 5678)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/id           | 9896/)
      expect(output).to match(/name         | sample-file.png/)
      expect(output).to match(/content_type | image\/png/)
    end
  end

  describe "adding new file" do
    it "uploads the new file to user space" do
      command = %W(file add --space-id 123456 #{file_attributes[:file]})

      stub_ribose_space_file_upload_api(123456, file_attributes)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/sample.png added to your space!/)
    end
  end

  def file_attributes
    { file: sample_fixture, description: "", tag_list: "" }
  end

  def sample_fixture
    @sample_fixture ||= File.join(Ribose.root, "spec/fixtures/sample.png")
  end
end
