# encoding: utf-8
require "spec_helper"

describe MpWeixin::Interface::Menu do
  let(:access_token) { 'ACCESS_TOKEN' }
  let(:token_hash) { {"expires_in" => "7200", "access_token" => access_token} }
  let(:menu_create_json) {
                    MultiJson.encode({
                      button: [
                      {
                        type: "click",
                        name: "今日歌曲",
                        key: "V1001_TODAY_MUSIC"
                      },
                      {
                        type: "click",
                        name: "歌手简介",
                        key: "V1001_TODAY_SINGER"
                      },
                      {
                         name: "菜单",
                         sub_button: [
                           {
                             type: "view",
                             name: "搜索",
                             url: "http://www.soso.com/"
                           },
                           {
                             type: "view",
                             name: "视频",
                             url: "http://v.qq.com/"
                           },
                           {
                             type: "click",
                             name: "赞一下我们",
                             key: "V1001_GOOD"
                           }]
                      }]
                    })
                  }

  let (:sucess_delete) {
                         MultiJson.encode({errcode: 0, errmsg: "ok"})
                       }
  let (:client) {
                   MpWeixin::Client.from_hash(token_hash) do |builder|
                     builder.request :url_encoded
                     builder.adapter :test do |stub|
                       stub.send(:post, "/cgi-bin/menu/create") {|env| [200, {'Content-Type' => 'application/json'}, menu_create_json]}
                       stub.send(:get, "/cgi-bin/menu/get") {|env| [200, {'Content-Type' => 'application/json'}, menu_create_json]}
                       stub.send(:get, "/cgi-bin/menu/delete") {|env| [200, {'Content-Type' => 'application/json'}, sucess_delete]}
                     end
                   end
                }

  context "#menu" do

    subject { MpWeixin::Interface::Menu.new(client) }

    it "create menu with menu_create_json" do
      expect(subject.create(menu_create_json).body).to eq(menu_create_json)
    end

    it "get_menu menu have been created" do
      expect(subject.get_menu.body).to eq(menu_create_json)
    end

    it "delete menu have been created" do
      expect(subject.delete.body).to eq(sucess_delete)
    end
  end
end
