# encoding: utf-8
module MpWeixin
  # The MpWeixin::Message class
  #
  class Event
    include ActiveModel::Model
    attr_accessor :ToUserName, :FromUserName,
                    :CreateTime, :MsgType

    # Instantiate a new Message with a hash of attributes
    #
    # @param [Hash] attributes the attributes value
    def initialize(attributes = nil)
      # Dynamic attr_accessible
      # maybe cause secret problem
      singleton_class.class_eval do
        attr_accessor *attributes.keys
      end

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
                      when 'event'
                        Event.new(hash)
                      else
                        # raise 'Unknown Message data'
                    end
        rescue
          logger.info('Unknown Message data #{xml}') if self.respond_to?(:logger)
        end
      end
    end
  end
end
