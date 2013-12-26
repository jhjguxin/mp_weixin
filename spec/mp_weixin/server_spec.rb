require "spec_helper"

describe MpWeixin::Server do

  let(:timestamp) { "1388028695" } #{ "#{Time.now.to_i}" }
  let(:nonce) { "121212121" }
  let(:signature)  { "9dc548e8c7fe32ac53f887e834a8c719a73cafc3" }# { generate_signature(token, timestamp, nonce) }
  let(:incorrent_signature) { SecureRandom.hex(64) }
  let(:echostr) { "22222222222222222" } #{ "#{Time.now.to_i}" }

  let(:text_message_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>1348831860</CreateTime>
    <MsgType><![CDATA[text]]></MsgType>
    <Content><![CDATA[this is a test]]></Content>
    <MsgId>1234567890123456</MsgId>
    </xml>
    )
  }

  context "get '/'" do
    it "should return when all are well" do
      get '/', signature: signature, timestamp: timestamp, nonce: nonce, echostr: echostr
      last_response.body.should eq(echostr)
    end

    it "should return with unauthorized 401" do
      get '/', signature: incorrent_signature, timestamp: timestamp, nonce: nonce, echostr: echostr
      last_response.status.should eq(401)
    end
  end

  context "#post '/'" do
    it "should return empty string when post invalide data" do
      post '/', "invalide data"
      last_response.status.should eq(400)
    end

    it "should return status 200 when post corrent data" do
      post '/', text_message_xml
      last_response.status.should eq(200)
    end
  end
end
