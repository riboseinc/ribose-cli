require "spec_helper"

RSpec.describe "Config" do
  it "allows us to set token and user email" do
    allow(File).to receive(:expand_path).and_return(fixtures_path)
    command = %w(config --token SECRET_TOKEN --email user-one@example.com)

    Ribose::CLI.start(command)

    expect(Ribose::CLI::RCFile.api_token).to eq("SECRET_TOKEN")
    expect(Ribose::CLI::RCFile.user_email).to eq("user-one@example.com")
  end

  def fixtures_path
    File.expand_path("../../fixtures", __FILE__)
  end
end
