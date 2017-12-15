require "spec_helper"

RSpec.describe "Ribose Space" do
  describe "Listing spaces" do
    context "default option" do
      it "retrieves user spaces in default format" do
        command = %w(space list)

        stub_ribose_space_list_api
        output = capture_stdout { Ribose::CLI.start(command) }

        expect(output).to match(/Work/)
        expect(output).to match(/0e8d5c16-1a31-4df9-83d9-eeaa374d5adc/)
      end
    end

    context "with format option" do
      it "retrieves user spaces in specified format" do
        command = %w(space list --format json)

        stub_ribose_space_list_api
        output = capture_stdout { Ribose::CLI.start(command) }

        expect(output).to match(/"name":"Work"/)
        expect(output).to match(/"id":"0e8d5c16-1a31-4df9-83d9-eeaa374d5adc"/)
      end
    end
  end

  describe "Retrieving a space" do
    context "with default options" do
      it "displays the space in tabular format" do
        command = %w(space show --space-id 123456789)

        stub_ribose_space_fetch_api(123_456_789)
        output = capture_stdout { Ribose::CLI.start(command) }

        expect(output).to match(/name          | Work/)
        expect(output).to match(/visibility    | invisible/)
      end
    end

    context "with format option" do
      it "displays as the space in supported format" do
        command = %w(space show --space-id 123456789 --format json)

        stub_ribose_space_fetch_api(123_456_789)
        output = capture_stdout { Ribose::CLI.start(command) }

        expect(output).to match(/"name":"Work"/)
        expect(output).to match(/"id":"0e8d5c16-1a31-4df9-83d9-eeaa374d5adc"/)
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

  describe "Updating a space" do
    it "updates an existing user space" do
      command = %W(
        space update
        --space-id 123456789
        --access #{space.access}
        --description #{space.description}
        --category-id #{space.category_id}
        --name #{space.name}
      )

      stub_ribose_space_update_api(123456789, space.to_h)
      output = capture_stdout { Ribose::CLI.start(command) }

      expect(output).to match(/Your space has been updated!/)
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
