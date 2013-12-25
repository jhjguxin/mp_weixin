# encoding: utf-8
require "spec_helper"

describe MpWeixin::Interface::User do
  let(:access_token) { 'ACCESS_TOKEN' }
  let(:token_hash) { {"expires_in" => "7200", "access_token" => access_token} }
  let(:openid) { "o6_bmjrPTlm6_2sgVt7hMZOPfL2M" }
  let(:info_json) {
                    MultiJson.encode({
                      openid: openid
                    })
                  }

  let (:sucess_info) {
                       MultiJson.encode({
                         subscribe: 1,
                         openid: openid,
                         nickname: "Band",
                         sex: 1,
                         language: "zh_CN",
                         city: "广州",
                         province: "广东",
                         country: "中国",
                         headimgurl:    "http://wx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/0",
                         subscribe_time: 1382694957
                       })
                     }
  let(:get_users_json) {
                    MultiJson.encode({
                      openid: openid
                    })
                  }
  let(:sucess_get_users) {
                    MultiJson.encode({
                      total: 2,
                      count: 2,
                      data: {
                        openid:
                        ["","OPENID1","OPENID2"]
                      },
                      next_openid: "NEXT_OPENID"
                    })
  }
  let(:client) {
                   MpWeixin::Client.from_hash(token_hash) do |builder|
                     builder.request :url_encoded
                     builder.adapter :test do |stub|
                       stub.send(:get, "/cgi-bin/user/info") {|env|
                         if env[:params].values.include?(openid)
                           [200, {'Content-Type' => 'application/json'}, sucess_info]
                         end
                       }
                       stub.send(:get, "/cgi-bin/user/get") {|env|
                         if env[:params].values.include?(openid)
                           [200, {'Content-Type' => 'application/json'}, sucess_get_users]
                         end
                       }
                     end
                   end
                }

  context "#menu" do

    subject { MpWeixin::Interface::User.new(client) }

    it "info info_hash with sucess_info return" do
      info_hash = JSON.parse info_json
      expect(subject.info(info_hash).body).to eq(sucess_info)
    end

    it "get_users get_users_hash with sucess_get_users return" do
      get_users_hash = JSON.parse get_users_json
      expect(subject.get_users(get_users_hash).body).to eq(sucess_get_users)
    end
  end
end
