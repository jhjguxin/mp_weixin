# encoding: utf-8
require "spec_helper"

describe MpWeixin::ServerHelper do
  include MpWeixin::ServerHelper

  let(:config) { MpWeixin::Config }
  let(:token) { config.token }
  let(:timestamp) { "1388028695" } #{ "#{Time.now.to_i}" }
  let(:nonce) { "121212121" }
  let(:signature)  { "9dc548e8c7fe32ac53f887e834a8c719a73cafc3" }# { generate_signature(token, timestamp, nonce) }
  let(:incorrent_signature) { SecureRandom.hex(64) }

  context "#generate_signature" do
    it "should generate an signature" do
      generate_signature(token, timestamp, nonce).should be_a(String)
    end
  end

  context "#valid_signature?" do
    it "should return true when every are well" do
      expect(valid_signature?(signature, timestamp, nonce)).to be_true
    end

    it "should return false if valid with incorrent_signature" do
      expect(valid_signature?(incorrent_signature, timestamp, nonce)).to be_false
    end
  end

  context "#reply message" do
    let(:text_message_hash) {
      {
        ToUserName: "toUser",
        FromUserName: "fromUser",
        CreateTime: "12345678",
        MsgType: "text",
        Content: "你好"
      }
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

    let(:voice_message_hash) {
      {
        ToUserName: "toUser",
        FromUserName: "fromUser",
        CreateTime: "12345678",
        MsgType: "voice",
        Voice: {MediaId: 'media_id'}
      }
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

    it "reply_text_message with attributes should be_a TextReplyMessage" do
      expect(reply_text_message(text_message_hash)).to be_a(MpWeixin::TextReplyMessage)
    end

    it "reply_image_message with attributes should be_a ImageReplyMessage" do
      expect(reply_image_message(image_message_hash)).to be_a(MpWeixin::ImageReplyMessage)
    end

    it "reply_voice_message with attributes should be_a VoiceReplyMessage" do
      expect(reply_voice_message(voice_message_hash)).to be_a(MpWeixin::VoiceReplyMessage)
    end

    it "reply_video_message with attributes should be_a VideoReplyMessage" do
      expect(reply_video_message(video_message_hash)).to be_a(MpWeixin::VideoReplyMessage)
    end

    it "reply_music_message with attributes should be_a MusicReplyMessage" do
      expect(reply_music_message(music_message_hash)).to be_a(MpWeixin::MusicReplyMessage)
    end

    it "reply_news_message with attributes should be_a NewsReplyMessage" do
      expect(reply_news_message(news_message_hash)).to be_a(MpWeixin::NewsReplyMessage)
    end
  end
end
