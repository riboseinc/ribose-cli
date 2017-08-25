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
end
