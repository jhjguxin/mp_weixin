# encoding: utf-8
require "spec_helper"

describe MpWeixin::Interface::Group do
  let(:access_token) { 'ACCESS_TOKEN' }
  let(:token_hash) { {"expires_in" => "7200", "access_token" => access_token} }
  let(:group_create_json) {
                    MultiJson.encode({
                                        group: {
                                          name: "test"
                                        }
                    })
                  }

  let (:sucess_create_group) {
                         MultiJson.encode({
                           group: {
                             id: 107,
                             name: "test"
                            }
                         })
                       }
  let (:all_groups) {
                      MultiJson.encode({
                        groups: [
                          {
                            id: 0,
                            name: "未分组",
                            count: 72596
                          },
                          {
                            id: 1,
                            name: "黑名单",
                            count: 36
                          },
                          {
                            id: 2,
                            name: "星标组",
                            count: 8
                          },
                          {
                            id: 104,
                            name: "华东媒",
                            count: 4
                          },
                          {
                            id: 106,
                            name: "★不测试组★",
                            count: 1
                          }
                        ]
                      })
                    }
  let(:getid_json) {
                     MultiJson.encode({
                                        openid: "od8XIjsmk6QdVTETa9jLtGWA6KBc"
                    })
                   }
  let(:sucess_getid) {
                    MultiJson.encode({
                      groupid: 102
                    })
  }
  let(:update_json) {
                    MultiJson.encode({
                      group: {
                        id: 108,
                        name: "test2_modify2"
                      }
                    })
  }

  let(:update_members_json) {
                    MultiJson.encode({
                      openid: "oDF3iYx0ro3_7jD4HFRDfrjdCM58",
                      to_groupid: 108
                    })
  }

  let (:client) {
                   MpWeixin::Client.from_hash(token_hash) do |builder|
                     builder.request :url_encoded
                     builder.adapter :test do |stub|
                       stub.send(:post, "/cgi-bin/groups/create") {|env|
                         if env[:body].eql?(group_create_json)
                           [200, {'Content-Type' => 'application/json'}, sucess_create_group]
                         end
                       }
                       stub.send(:get, "/cgi-bin/groups/get") {|env| [200, {'Content-Type' => 'application/json'}, all_groups]}
                       stub.send(:post, "/cgi-bin/groups/getid") {|env|
                         if env[:body].eql?(getid_json)
                           [200, {'Content-Type' => 'application/json'}, sucess_getid]
                         end
                       }
                       stub.send(:post, "/cgi-bin/groups/update") {|env|
                         [200, {'Content-Type' => 'application/json'}, env[:body]]
                       }
                       stub.send(:post, "/cgi-bin/groups/members/update") {|env|
                         [200, {'Content-Type' => 'application/json'}, env[:body]]
                       }
                     end
                   end
                }

  context "#group" do

    subject { MpWeixin::Interface::Group.new(client) }

    it "create group with group_create_json" do
      group_create_hash = JSON.parse group_create_json
      expect(subject.create(group_create_hash).body).to eq(sucess_create_group)
    end

    it "get_groups all group have been created" do
      expect(subject.get_groups.body).to eq(all_groups)
    end

    it "getid return groupid getid_hash within openid have been joined in" do
      getid_hash = JSON.parse getid_json
      expect(subject.getid(getid_hash).body).to eq(sucess_getid)
    end

    it "update update_hash have been created" do
      update_hash = JSON.parse update_json
      expect(subject.update(update_hash).body).to eq(update_json)
    end

    it "update_memgers move openid to groupid" do
      update_members_hash = JSON.parse update_members_json
      expect(subject.update_memgers(update_members_hash).body).to eq(update_members_json)
    end
  end
end
