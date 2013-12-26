# encoding: utf-8

require "spec_helper"

describe MpWeixin::Message do

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

  let(:image_message_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>1348831860</CreateTime>
    <MsgType><![CDATA[image]]></MsgType>
    <PicUrl><![CDATA[this is a url]]></PicUrl>
    <MediaId><![CDATA[media_id]]></MediaId>
    <MsgId>1234567890123456</MsgId>
    </xml>
    )
  }

  let(:voice_message_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>1357290913</CreateTime>
    <MsgType><![CDATA[voice]]></MsgType>
    <MediaId><![CDATA[media_id]]></MediaId>
    <Format><![CDATA[Format]]></Format>
    <MsgId>1234567890123456</MsgId>
    </xml>
    )
  }

  let(:video_message_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>1357290913</CreateTime>
    <MsgType><![CDATA[video]]></MsgType>
    <MediaId><![CDATA[media_id]]></MediaId>
    <ThumbMediaId><![CDATA[thumb_media_id]]></ThumbMediaId>
    <MsgId>1234567890123456</MsgId>
    </xml>
    )
  }

  let(:location_message_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>1351776360</CreateTime>
    <MsgType><![CDATA[location]]></MsgType>
    <Location_X>23.134521</Location_X>
    <Location_Y>113.358803</Location_Y>
    <Scale>20</Scale>
    <Label><![CDATA[位置信息]]></Label>
    <MsgId>1234567890123456</MsgId>
    </xml>
    )
  }


  let(:link_message_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>1351776360</CreateTime>
    <MsgType><![CDATA[link]]></MsgType>
    <Title><![CDATA[公众平台官网链接]]></Title>
    <Description><![CDATA[公众平台官网链接]]></Description>
    <Url><![CDATA[url]]></Url>
    <MsgId>1234567890123456</MsgId>
    </xml>
    )
  }

  context "#from_xml" do
    context ":text_message_xml" do
      subject { MpWeixin::Message.from_xml(text_message_xml) }

      it "should return an instance of TextMessage" do
        expect(subject).to be_a(MpWeixin::TextMessage)
      end

      it "should have MsgType text" do
        expect(subject.MsgType).to eq("text")
      end
      it "should have corrent Content" do
        expect(subject.Content).to eq("this is a test")
      end

      it "should have corrent MsgId" do
        expect(subject.MsgId).to eq("1234567890123456")
      end
    end

    context ":image_message_xml" do
      subject { MpWeixin::Message.from_xml(image_message_xml) }

      it "should return an instance of ImageMessage" do
        expect(subject).to be_a(MpWeixin::ImageMessage)
      end

      it "should have correct MsgType" do
        expect(subject.MsgType).to eq("image")
      end
      it "should have corrent PicUrl" do
        expect(subject.PicUrl).to eq("this is a url")
      end
    end

    context ":voice_message_xml" do
      subject { MpWeixin::Message.from_xml(voice_message_xml) }

      it "should return an instance of VoiceMessage" do
        expect(subject).to be_a(MpWeixin::VoiceMessage)
      end

      it "should have correct MsgType" do
        expect(subject.MsgType).to eq("voice")
      end
      it "should have corrent Format" do
        expect(subject.Format).to eq("Format")
      end
    end

    context ":video_message_xml" do
      subject { MpWeixin::Message.from_xml(video_message_xml) }

      it "should return an instance of VoiceMessage" do
        expect(subject).to be_a(MpWeixin::VideoMessage)
      end

      it "should have correct MsgType" do
        expect(subject.MsgType).to eq("video")
      end
      it "should have corrent ThumbMediaId" do
        expect(subject.ThumbMediaId).to eq("thumb_media_id")
      end
    end

    context ":location_message_xml" do
      subject { MpWeixin::Message.from_xml(location_message_xml) }

      it "should return an instance of LocationMessage" do
        expect(subject).to be_a(MpWeixin::LocationMessage)
      end

      it "should have correct MsgType" do
        expect(subject.MsgType).to eq("location")
      end
      it "should have corrent Location_X" do
        expect(subject.Location_X).to eq("23.134521")
      end
    end

    context ":link_message_xml" do
      subject { MpWeixin::Message.from_xml(link_message_xml) }

      it "should return an instance of LinkMessage" do
        expect(subject).to be_a(MpWeixin::LinkMessage)
      end

      it "should have correct MsgType" do
        expect(subject.MsgType).to eq("link")
      end
      it "should have corrent Url" do
        expect(subject.Url).to eq("url")
      end
    end
  end
end
