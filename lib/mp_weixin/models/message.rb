# encoding: utf-8

module MpWeixin
  # The MpWeixin::Message class
  #
  class Message
    include ActiveModel::Model
    attr_accessor :ToUserName, :FromUserName,
                    :CreateTime, :MsgType, :MsgId

    # Instantiate a new Message with a hash of attributes
    #
    # @param [Hash] attributes the attributes value
    def initialize(attributes = nil)
      # Dynamic attr_accessible
      # maybe cause secret problem
      # singleton_class.class_eval do
      #   attr_accessor *attributes.keys
      # end

      super
      @source = ActiveSupport::HashWithIndifferentAccess.new(attributes)
    end

    # same as @attributes CreateTime of an Message instance
    #
    # @return [Integer]
    def create_time
      self.CreateTime.to_i
    end
    # alias :CreateTime :create_time

    # convert create_time to an Time instance
    #
    # @return [Time]
    def created_at
      Time.at create_time rescue nil
    end

    def msg_id
      self.MsgId.to_i
    end

    # initialize an ReplyMessage
    # @msg_type [string] the MsgType of ReplyMessage
    # @attributes [Hash] the attributes of ReplyMessage
    # @return an instance of #{MsgType}ReplyMessage
    def reply(msg_type, attributes)
      if attributes.is_a?(Hash)
        attributes = attributes.deep_symbolize_keys
        attributes.reverse_merge!({
          ToUserName: self.FromUserName,
          FromUserName: self.ToUserName
        })
      end

      case msg_type
        when 'text'
          MpWeixin::TextReplyMessage.new(attributes)
        when 'image'
          MpWeixin::ImageReplyMessage.new(attributes)
        when 'voice'
          MpWeixin::VoiceReplyMessage.new(attributes)
        when 'video'
          MpWeixin::VideoReplyMessage.new(attributes)
        when 'music'
          MpWeixin::MusicReplyMessage.new(attributes)
        when 'news'
          MpWeixin::NewsReplyMessage.new(attributes)
        else
          # raise 'Unknown Message data'
      end
    end

    # initialize an TextReplyMessage
    # @attributes [Hash] the attributes of TextReplyMessage
    def reply_text_message(attributes)
      reply("text", attributes)
    end

    # initialize an ImageReplyMessage
    # @attributes [Hash] the attributes of ImageReplyMessage
    def reply_image_message(attributes)
      reply("image", attributes)
    end

    # initialize an VoiceReplyMessage
    # @attributes [Hash] the attributes of VoiceReplyMessage
    def reply_voice_message(attributes)
      reply("voice", attributes)
    end

    # initialize an VideoReplyMessage
    # @attributes [Hash] the attributes of VideoReplyMessage
    def reply_video_message(attributes)
      reply("video", attributes)
    end

    # initialize an MusicReplyMessage
    # @attributes [Hash] the attributes of MusicReplyMessage
    def reply_music_message(attributes)
      reply("music", attributes)
    end

    # initialize an NewsReplyMessage
    # @attributes [Hash] the attributes of NewsReplyMessage
    def reply_news_message(attributes)
      reply("news", attributes)
    end

    class << self
      def from_xml(xml)
        begin
          hash = MultiXml.parse(xml)['xml']
          message = case hash['MsgType']
                      when 'text'
                        TextMessage.new(hash)
                      when 'image'
                        ImageMessage.new(hash)
                      when 'location'
                        LocationMessage.new(hash)
                      when 'link'
                        LinkMessage.new(hash)
                      when 'event'
                        # EventMessage.new(hash)
                        Event.from_xml(xml)
                      when 'voice'
                        VoiceMessage.new(hash)
                      when 'video'
                        VideoMessage.new(hash)
                      else
                        # raise 'Unknown Message data'
                    end
        rescue
          logger.info('Unknown Message data #{xml}') if self.respond_to?(:logger)
        end
      end
    end
  end

  #   <xml>
  #     <ToUserName><![CDATA[toUser]]></ToUserName>
  #     <FromUserName><![CDATA[fromUser]]></FromUserName>
  #     <CreateTime>1348831860</CreateTime>
  #     <MsgType><![CDATA[text]]></MsgType>
  #     <Content><![CDATA[this is a test]]></Content>
  #     <MsgId>1234567890123456</MsgId>
  #   </xml>
  # TextMessage = Class.new(Message)
  class TextMessage < Message
    attr_accessor :Content
  end

  #   <xml>
  #     <ToUserName><![CDATA[toUser]]></ToUserName>
  #     <FromUserName><![CDATA[fromUser]]></FromUserName>
  #     <CreateTime>1348831860</CreateTime>
  #     <MsgType><![CDATA[image]]></MsgType>
  #     <PicUrl><![CDATA[this is a url]]></PicUrl>
  #     <MsgId>1234567890123456</MsgId>
  #   </xml>
  # ImageMessage = Class.new(Message)
  class ImageMessage < Message
    attr_accessor :PicUrl, :MediaId
  end

  #   <xml>
  #     <ToUserName><![CDATA[toUser]]></ToUserName>
  #     <FromUserName><![CDATA[fromUser]]></FromUserName>
  #     <CreateTime>1376632760</CreateTime>
  #     <MsgType><![CDATA[voice]]></MsgType>
  #     <MediaId><![CDATA[Qyb0tgux6QLjhL6ipvFZJ-kUt2tcQtkn0BU365Vt3wUAtqfGam4QpZU35RXVhv6G]]></MediaId>
  #     <Format><![CDATA[amr]]></Format>
  #     <MsgId>5912592682802219078</MsgId>
  #     <Recognition><![CDATA[]]></Recognition>
  #   </xml>
  # VoiceMessage = Class.new(Message)
  class VoiceMessage < Message
    attr_accessor :MediaId, :Format
  end

  #   <xml>
  #     <ToUserName><![CDATA[toUser]]></ToUserName>
  #     <FromUserName><![CDATA[fromUser]]></FromUserName>
  #     <CreateTime>1376632994</CreateTime>
  #     <MsgType><![CDATA[video]]></MsgType>
  #     <MediaId><![CDATA[TAAGb6iS5LcZR1d5ICiZTWGWi6-Upic9tlWDpAKcNJA]]></MediaId>
  #     <ThumbMediaId><![CDATA[U-xulPW4kq6KKMWFNaBSPc65Bcgr7Qopwex0DfCeyQs]]></ThumbMediaId>
  #     <MsgId>5912593687824566343</MsgId>
  #   </xml>
  # VideoMessage = Class.new(Message)
  class VideoMessage < Message
    attr_accessor :MediaId, :ThumbMediaId
  end

  #   <xml>
  #     <ToUserName><![CDATA[toUser]]></ToUserName>
  #     <FromUserName><![CDATA[fromUser]]></FromUserName>
  #     <CreateTime>1351776360</CreateTime>
  #     <MsgType><![CDATA[location]]></MsgType>
  #     <Location_X>23.134521</Location_X>
  #     <Location_Y>113.358803</Location_Y>
  #     <Scale>20</Scale>
  #     <Label><![CDATA[位置信息]]></Label>
  #     <MsgId>1234567890123456</MsgId>
  #   </xml>
  # LocationMessage = Class.new(Message)
  class LocationMessage < Message
    attr_accessor :Location_X , :Location_Y, :Scale, :Label
  end

  #   <xml>
  #     <ToUserName><![CDATA[toUser]]></ToUserName>
  #     <FromUserName><![CDATA[fromUser]]></FromUserName>
  #     <CreateTime>1351776360</CreateTime>
  #     <MsgType><![CDATA[link]]></MsgType>
  #     <Title><![CDATA[公众平台官网链接]]></Title>
  #     <Description><![CDATA[公众平台官网链接]]></Description>
  #     <Url><![CDATA[url]]></Url>
  #     <MsgId>1234567890123456</MsgId>
  #   </xml>
  #
  # LinkMessage = Class.new(Message)
  class LinkMessage < Message
    attr_accessor :Title , :Description, :Url
  end
end
