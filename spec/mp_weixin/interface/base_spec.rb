require "spec_helper"

describe MpWeixin::Interface::Base do
  let(:access_token) { 'ACCESS_TOKEN' }
  let(:token_hash) { {"expires_in" => "7200", "access_token" => access_token} }
  let (:client) { MpWeixin::Client.from_hash(token_hash) }

  context "#initialize interface" do
    subject { MpWeixin::Interface::Base.new(client) }

    it "should have default_request_params" do
      expect(subject.default_request_params).to eq({"access_token" => access_token})
    end

  end
end
