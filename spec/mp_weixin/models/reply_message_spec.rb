# encoding: utf-8
require "spec_helper"

describe "MpWeixin::ReplyMessage" do
  let(:text_message_hash) {
    {
      ToUserName: "toUser",
      FromUserName: "fromUser",
      CreateTime: "12345678",
      MsgType: "text",
      Content: "你好"
    }
  }

  let(:text_message_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>12345678</CreateTime>
    <MsgType><![CDATA[text]]></MsgType>
    <Content><![CDATA[你好]]></Content>
    </xml>
    )
  }

  let(:image_message_hash) {
    {
      ToUserName: "toUser",
      FromUserName: "fromUser",
      CreateTime: "12345678",
      MsgType: "image",
      Image: {MediaId: 'media_id'}
    }
  }

  let(:image_message_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>12345678</CreateTime>
    <MsgType><![CDATA[image]]></MsgType>
    <Image>
    <MediaId><![CDATA[media_id]]></MediaId>
    </Image>
    </xml>
    )
  }

  let(:voice_message_hash) {
    {
      ToUserName: "toUser",
      FromUserName: "fromUser",
      CreateTime: "12345678",
      MsgType: "voice",
      Voice: {MediaId: 'media_id'}
    }
  }
  let(:voice_message_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>12345678</CreateTime>
    <MsgType><![CDATA[voice]]></MsgType>
    <Voice>
    <MediaId><![CDATA[media_id]]></MediaId>
    </Voice>
    </xml>
    )
  }

  let(:video_message_hash) {
    {
      ToUserName: "toUser",
      FromUserName: "fromUser",
      CreateTime: "12345678",
      MsgType: "video",
      Video: {
        MediaId: "media_id",
        Title: "title",
        Description: "description"
      }
    }
  }
  let(:video_message_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>12345678</CreateTime>
    <MsgType><![CDATA[video]]></MsgType>
    <Video>
    <MediaId><![CDATA[media_id]]></MediaId>
    <Title><![CDATA[title]]></Title>
    <Description><![CDATA[description]]></Description>
    </Video>
    </xml>
    )
  }

  let(:music_message_hash) {
    {
      ToUserName: "toUser",
      FromUserName: "fromUser",
      CreateTime: "12345678",
      MsgType: "music",
      Music: {
        Title: "TITLE",
        Description: "DESCRIPTION",
        MusicUrl: "MUSIC_Url",
        HQMusicUrl: "HQ_MUSIC_Url",
        ThumbMediaId: "media_id"
      }
    }
  }
  let(:music_message_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>12345678</CreateTime>
    <MsgType><![CDATA[music]]></MsgType>
    <Music>
    <Title><![CDATA[TITLE]]></Title>
    <Description><![CDATA[DESCRIPTION]]></Description>
    <MusicUrl><![CDATA[MUSIC_Url]]></MusicUrl>
    <HQMusicUrl><![CDATA[HQ_MUSIC_Url]]></HQMusicUrl>
    <ThumbMediaId><![CDATA[media_id]]></ThumbMediaId>
    </Music>
    </xml>
    )
  }


  let(:news_message_simple_hash) {
    {
      ToUserName: "toUser",
      FromUserName: "fromUser",
      CreateTime: "12345678",
      MsgType: "news",
      ArticleCount: "2",
      Articles: [
        {
          Title: "title1",
          Description: "description1",
          PicUrl: "picurl",
          Url: "url"
        },
        {
          Title: "title",
          Description: "description",
          PicUrl: "picurl",
          Url: "url"
        }
      ]
    }
  }

  let(:news_message_hash) {
    {
      ToUserName: "toUser",
      FromUserName: "fromUser",
      CreateTime: "12345678",
      MsgType: "news",
      ArticleCount: "2",
      Articles: {
        item: [
          {
            Title: "title1",
            Description: "description1",
            PicUrl: "picurl",
            Url: "url"
          },
          {
            Title: "title",
            Description: "description",
            PicUrl: "picurl",
            Url: "url"
          }
        ]
      }
    }
  }

  let(:news_message_xml) {
    %(
    <xml>
    <ToUserName><![CDATA[toUser]]></ToUserName>
    <FromUserName><![CDATA[fromUser]]></FromUserName>
    <CreateTime>12345678</CreateTime>
    <MsgType><![CDATA[news]]></MsgType>
    <ArticleCount>2</ArticleCount>
    <Articles>
    <item>
    <Title><![CDATA[title1]]></Title>
    <Description><![CDATA[description1]]></Description>
    <PicUrl><![CDATA[picurl]]></PicUrl>
    <Url><![CDATA[url]]></Url>
    </item>
    <item>
    <Title><![CDATA[title]]></Title>
    <Description><![CDATA[description]]></Description>
    <PicUrl><![CDATA[picurl]]></PicUrl>
    <Url><![CDATA[url]]></Url>
    </item>
    </Articles>
    </xml>
    )
  }

  context "TextReplyMessage" do
    subject { MpWeixin::TextReplyMessage.new(text_message_hash) }

    context "initialize new" do

      it "should return an instance of TextReplyMessage" do
        expect(subject).to be_a(MpWeixin::TextReplyMessage)
      end

      it "should have correct MsgType" do
        expect(subject.MsgType).to eq("text")
      end
    end

    context ":to_xml" do
      let(:want_be_hash) { Hash.from_xml(subject.to_xml).deep_symbolize_keys[:xml] }
      let(:weixin_xml_hash) { Hash.from_xml(text_message_xml).deep_symbolize_keys[:xml] }

      it "should return correct xml" do
        expect(want_be_hash).to eq(weixin_xml_hash)
      end
    end
  end

  context "ImageReplyMessage" do
    subject { MpWeixin::ImageReplyMessage.new(image_message_hash) }

    context "initialize new" do

      it "should return an instance of ImageReplyMessage" do
        expect(subject).to be_a(MpWeixin::ImageReplyMessage)
      end

      it "should have correct MsgType" do
        expect(subject.MsgType).to eq("image")
      end
    end

    context ":to_xml" do
      let(:want_be_hash) { Hash.from_xml(subject.to_xml).deep_symbolize_keys[:xml] }
      let(:weixin_xml_hash) { Hash.from_xml(image_message_xml).deep_symbolize_keys[:xml] }

      it "should return correct xml" do
        expect(want_be_hash).to eq(weixin_xml_hash)
      end
    end
  end

  context "VoiceReplyMessage" do
    subject { MpWeixin::VoiceReplyMessage.new(voice_message_hash) }

    context "initialize new" do

      it "should return an instance of VoiceReplyMessage" do
        expect(subject).to be_a(MpWeixin::VoiceReplyMessage)
      end

      it "should have correct MsgType" do
        expect(subject.MsgType).to eq("voice")
      end
    end

    context ":to_xml" do
      let(:want_be_hash) { Hash.from_xml(subject.to_xml).deep_symbolize_keys[:xml] }
      let(:weixin_xml_hash) { Hash.from_xml(voice_message_xml).deep_symbolize_keys[:xml] }

      it "should return correct xml" do
        expect(want_be_hash).to eq(weixin_xml_hash)
      end
    end
  end

  context "VideoReplyMessage" do
    subject { MpWeixin::VideoReplyMessage.new(video_message_hash) }

    context "initialize new" do

      it "should return an instance of VideoReplyMessage" do
        expect(subject).to be_a(MpWeixin::VideoReplyMessage)
      end

      it "should have correct MsgType" do
        expect(subject.MsgType).to eq("video")
      end
    end

    context ":to_xml" do
      let(:want_be_hash) { Hash.from_xml(subject.to_xml).deep_symbolize_keys[:xml] }
      let(:weixin_xml_hash) { Hash.from_xml(video_message_xml).deep_symbolize_keys[:xml] }

      it "should return correct xml" do
        expect(want_be_hash).to eq(weixin_xml_hash)
      end
    end
  end

  context "MusicReplyMessage" do
    subject { MpWeixin::MusicReplyMessage.new(music_message_hash) }

    context "initialize new" do

      it "should return an instance of MusicReplyMessage" do
        expect(subject).to be_a(MpWeixin::MusicReplyMessage)
      end

      it "should have correct MsgType" do
        expect(subject.MsgType).to eq("music")
      end
    end

    context ":to_xml" do
      let(:want_be_hash) { Hash.from_xml(subject.to_xml).deep_symbolize_keys[:xml] }
      let(:weixin_xml_hash) { Hash.from_xml(music_message_xml).deep_symbolize_keys[:xml] }

      it "should return correct xml" do
        expect(want_be_hash).to eq(weixin_xml_hash)
      end
    end
  end

  context "NewsReplyMessage" do
    subject { MpWeixin::NewsReplyMessage.new(news_message_hash) }

    context "initialize new" do

      it "should return an instance of NewsReplyMessage" do
        expect(subject).to be_a(MpWeixin::NewsReplyMessage)
      end

      it "should have correct MsgType" do
        expect(subject.MsgType).to eq("news")
      end
    end

    context ":to_xml" do
      let(:want_be_hash) { Hash.from_xml(subject.to_xml).deep_symbolize_keys[:xml] }
      let(:weixin_xml_hash) { Hash.from_xml(news_message_xml).deep_symbolize_keys[:xml] }

      it "should return correct xml" do
        expect(want_be_hash).to eq(weixin_xml_hash)
      end
    end

    context ":to_xml simple type" do
      let(:want_be_hash) { Hash.from_xml(MpWeixin::NewsReplyMessage.new(news_message_simple_hash).to_xml).deep_symbolize_keys[:xml] }
      let(:weixin_xml_hash) { Hash.from_xml(news_message_xml).deep_symbolize_keys[:xml] }

      it "should return correct xml" do
        expect(want_be_hash).to eq(weixin_xml_hash)
      end
    end
  end
end
