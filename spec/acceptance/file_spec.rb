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

  describe "update" do
    it "updates details for a space file" do
      command = %W(
        file update
        --file-id 5678
        --space-id 1234
        --tags #{update_attributes[:tags]}
        --file-name #{update_attributes[:file_name]}
        --description #{update_attributes[:description]}
      )

      stub_ribose_space_file_update_api(1234, 5678, update_attributes)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/The file has been updated with new attributes/)
    end
  end

  describe "remove" do
    it "removes a file from a user space" do
      command = %w(file remove --file-id 5678 --space-id 1234)

      stub_ribose_space_file_delete_api(1234, 5678)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/The file has been removed from your space!/)
    end
  end

  def file_attributes
    { file: sample_fixture, description: "", tag_list: "" }
  end

  def update_attributes
    { tags: "one, two", file_name: "new name", description: "New description" }
  end

  def sample_fixture
    @sample_fixture ||= File.join(Ribose.root, "spec/fixtures/sample.png")
  end
end
