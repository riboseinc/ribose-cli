require "spec_helper"

RSpec.describe "Ribose Space" do
  describe "Listing spaces" do
    it "retrieves and list out user spaces" do
      command = %w(space list)
      stub_listing_ribose_spaces

      Ribose::CLI.start(command)

      expect(Ribose::Space).to have_received(:all)
    end
  end

  def stub_listing_ribose_spaces
    allow(Ribose::Space).to receive(:all).and_return([])
  end
end
