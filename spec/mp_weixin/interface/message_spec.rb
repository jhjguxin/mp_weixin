# encoding: utf-8
require "spec_helper"

describe MpWeixin::Interface::Message do
  let(:access_token) { 'ACCESS_TOKEN' }
  let(:token_hash) { {"expires_in" => "7200", "access_token" => access_token} }
  let(:text_json) {
                    MultiJson.encode({
                        touser: "OPENID",
                        msgtype: "text",
                        text:
                        {
                             content: "Hello World"
                        }
                    })

                  }
  let (:client) {
                   MpWeixin::Client.from_hash(token_hash) do |builder|
                     builder.request :url_encoded
                     builder.adapter :test do |stub|
                       stub.send(:post, "/cgi-bin/message/custom/send") {|env| [200, {'Content-Type' => 'application/json'}, text_json]}
                     end
                   end
                }

  context "#custom_send" do

    subject { MpWeixin::Interface::Message.new(client) }

    it "should have can post text_json" do
      expect(subject.custom_send(text_json).body).to eq(text_json)
    end

  end
end
