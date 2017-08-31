require "spec_helper"

RSpec.describe "Ribose Space" do
  describe "Listing spaces" do
    context "default option" do
      it "retrieves user spaces in default format" do
        command = %w(space list)

        stub_ribose_space_list_api
        output = capture_stdout { Ribose::CLI.start(command) }

        expect(output).to match(/Work/)
        expect(output).to match(/123456789/)
      end
    end

    context "with format option" do
      it "retrieves user spaces in specified format" do
        command = %w(space list --format json)

        stub_ribose_space_list_api
        output = capture_stdout { Ribose::CLI.start(command) }

        expect(output).to match(/"name":"Work"/)
        expect(output).to match(/"id":"123456789"/)
      end
    end
  end

  describe "Adding a new space" do
    it "allows us to add a new space" do
      command = %W(
        space add
        --name #{space.name}
        --access #{space.access}
        --description #{space.description}
        --category-id #{space.category_id}
      )

      stub_ribose_space_create_api(space.to_h)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/New Space created!/)
      expect(output).to match(/Id: 6b2741ad-4cde-4b4d-af3b-a162a4f6bc25/)
    end
  end

  describe "Remove an existing space" do
    it "removes an existing space" do
      space_uuid = "6b2741ad-4cde-4b4d-af3b-a162a4f6bc25"
      command = %W(space remove --space-id #{space_uuid} --confirmation 12345)

      stub_ribose_space_remove_api(space_uuid, password_confirmation: "12345")
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/The Sapce has been removed!/)
    end
  end

  def space
    @space ||= OpenStruct.new(
      access: "public",
      description: "Space description",
      category_id: "12",
      name: "CLI Space",
    )
  end
end
