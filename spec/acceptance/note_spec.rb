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

  describe "retrieve a note" do
    it "retrieves the details for a note" do
      command = %w(note show --space-id 123456 --note-id 789012)

      stub_ribose_wiki_fetch_api(123456, 789012)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/revision | 23/)
      expect(output).to match(/name     | Wiki Page One/)
      expect(output).to match(/address  | wiki-page-one/)
    end
  end

  describe "adding a new note" do
    it "adds a new note to a specific space" do
      command = %w(note add -s 123456 --title Home --tag-list hello)
      stub_ribose_wiki_create_api(123_456, tag_list: "hello", name: "Home")

      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/Note has been posted added! Id:/)
    end
  end

  describe "remove a note" do
    it "removes a note from a specific space" do
      command = %w(note remove -s 123456789 --note-id 789123456)

      stub_ribose_wiki_delete_api(123456789, 789123456)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/The note has been removed!/)
    end
  end
end
