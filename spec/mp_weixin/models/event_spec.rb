# encoding: utf-8

require "spec_helper"

describe MpWeixin::Event do

  let(:subscribe_event_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[FromUser]]></FromUserName>
    <CreateTime>123456789</CreateTime>
    <MsgType><![CDATA[event]]></MsgType>
    <Event><![CDATA[subscribe]]></Event>
    </xml>
    )
  }

  let(:location_event_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>123456789</CreateTime>
    <MsgType><![CDATA[event]]></MsgType>
    <Event><![CDATA[LOCATION]]></Event>
    <Latitude>23.137466</Latitude>
    <Longitude>113.352425</Longitude>
    <Precision>119.385040</Precision>
    </xml>
    )
  }

  let(:click_event_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[FromUser]]></FromUserName>
    <CreateTime>123456789</CreateTime>
    <MsgType><![CDATA[event]]></MsgType>
    <Event><![CDATA[CLICK]]></Event>
    <EventKey><![CDATA[EVENTKEY]]></EventKey>
    </xml>
    )
  }

  context "#from_xml" do
    context ":subscribe_event_xml" do
      # subject { MpWeixin::Event.from_xml(subscribe_event_xml) }
      subject { MpWeixin::Message.from_xml(subscribe_event_xml) }

      it "should return an instance of Event" do
        expect(subject).to be_a(MpWeixin::Event)
      end

      it "should have corrent Event" do
        expect(subject.Event).to eq("subscribe")
      end
    end

    context ":location_event_xml" do
      # subject { MpWeixin::Event.from_xml(location_event_xml) }
      subject { MpWeixin::Message.from_xml(location_event_xml) }

      it "should return an instance of Event" do
        expect(subject).to be_a(MpWeixin::Event)
      end

      it "should have correct Event" do
        expect(subject.Event).to eq("LOCATION")
      end
      it "should have corrent Latitude" do
        expect(subject.Latitude).to eq("23.137466")
      end
    end

    context ":click_event_xml" do
      # subject { MpWeixin::Event.from_xml(click_event_xml) }
      subject { MpWeixin::Message.from_xml(click_event_xml) }

      it "should return an instance of Event" do
        expect(subject).to be_a(MpWeixin::Event)
      end

      it "should have corrent Event" do
        expect(subject.Event).to eq("CLICK")
      end

      it "should have corrent EventKey" do
        expect(subject.EventKey).to eq("EVENTKEY")
      end
    end
  end
end
