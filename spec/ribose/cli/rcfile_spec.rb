require "spec_helper"
require "ribose/cli/rcfile"

RSpec.describe Ribose::CLI::RCFile do
  describe ".set" do
    it "allows us to set API Token and User Email" do
      api_token = "SECRET_TOKEN"
      user_email = "user-one@example.com"
      user_password = "SECRET_PASSWORD"
      allow(File).to receive(:expand_path).and_return(fixtures_path)

      Ribose::CLI::RCFile.set(
        token: api_token,
        email: user_email,
        password: user_password,
      )

      expect(Ribose::CLI::RCFile.api_token).to eq(api_token)
      expect(Ribose::CLI::RCFile.user_email).to eq(user_email)
      expect(Ribose::CLI::RCFile.user_password).to eq(user_password)
    end
  end

  def fixtures_path
    File.expand_path("../../../fixtures", __FILE__)
  end
end
