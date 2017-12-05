require "spec_helper"

RSpec.describe "Space Note" do
  describe "listing notes" do
    it "retrieves the list of notes" do
      command = %w(note list --space-id 123456789)

      stub_ribose_wiki_list_api(123_456_789)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/Wiki Page One/)
      expect(output).to match(/Wiki Page Two/)
    end
  end

  describe "adding a new note" do
    it "adds a new note to a specific space" do
      command = %w(note add -s 123456 --title Home)
      stub_ribose_wiki_create_api(123_456, tag_list: nil, name: "Home")

      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/Note has been posted added! Id:/)
    end
  end
end
