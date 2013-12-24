# encoding: utf-8
require "spec_helper"

describe MpWeixin::Interface::Promotion do
  let(:access_token) { 'ACCESS_TOKEN' }
  let(:token_hash) { {"expires_in" => "7200", "access_token" => access_token} }
  let(:qrcode_create_json) {
                           MultiJson.encode({
                              expire_seconds: 1800,
                              action_name: "QR_SCENE",
                              action_info: {
                                             scene: { scene_id: 123}
                                           }
                    })
                  }
  let (:ticket) { "gQG28DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0FuWC1DNmZuVEhvMVp4NDNMRnNRAAIEesLvUQMECAcAAA==" }

  let (:sucess_create) {
                         MultiJson.encode({
                            ticket: ticket,
                            expire_seconds: 1800
                         })
                       }
  let (:client) {
                   MpWeixin::Client.from_hash(token_hash) do |builder|
                     builder.request :url_encoded
                     builder.adapter :test do |stub|
                       stub.send(:post, '/cgi-bin/qrcode/create') {|env| [200, {'Content-Type' => 'application/json'}, sucess_create]}
                       stub.send(:get, '/cgi-bin/showqrcode') {|env|
                         [200, {'Content-Type' => 'image/jpg'}, nil] if env[:url].to_s.include?("https://mp.weixin.qq.com/cgi-bin/showqrcode")
                       }
                     end
                   end
                }

  context "#promotion" do

    subject { MpWeixin::Interface::Promotion.new(client) }

    it "create qrcode with qrcode_create_json" do
      expect(subject.create(qrcode_create_json).body).to eq(sucess_create)
    end

    it "showqrcode qrcode with ticket" do
      expect(subject.showqrcode(ticket).content_type).to eq("image/jpg")
    end
  end
end
