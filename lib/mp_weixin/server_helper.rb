# encoding: utf-8
module MpWeixin
  module ServerHelper

    # generate a signature string through sha1 encrypt token, timestamp, nonce .
    #
    # @param [String] token the token value
    # @param [String] timestamp the timestamp value from weixin
    # @param [String] nonce the random num from weixin
    #
    #    加密/校验流程如下：
    #    1. 将token、timestamp、nonce三个参数进行字典序排序
    #    2. 将三个参数字符串拼接成一个字符串进行sha1加密
    #    3. 开发者获得加密后的字符串可与signature对比，标识该请求来源于微信
    #
    # @return [String]
    def generate_signature(token, timestamp, nonce)
      signature_content = [token.to_s, timestamp.to_s, nonce.to_s].sort.join("")
      Digest::SHA1.hexdigest(signature_content)
    end

    # Whether or not the signature is eql with local_signature
    #
    # @param [String] signature the signature value need validate
    # @param [String] timestamp the timestamp value from weixin
    # @param [String] nonce the nonce value
    #
    # @return [Boolean]
    def valid_signature?(signature, timestamp, nonce)
      token = Config.token

      local_signature = generate_signature(token,timestamp,nonce)
      local_signature.eql? signature
    end

    # initialize an TextReplyMessage
    # @param [Hash] attributes
    # @see 'spec/mp_weixin/models/reply_message_spec.rb'
    def reply_text_message(attributes = {})
      MpWeixin::TextReplyMessage.new(attributes)
    end

    # initialize an ImageReplyMessage
    # @param [Hash] attributes
    # @see 'spec/mp_weixin/models/reply_message_spec.rb'
    def reply_image_message(attributes = {}, &block)
      reply_message = MpWeixin::ImageReplyMessage.new(attributes)
      block.call(reply_message) if block_given?

      reply_message
    end

    # initialize an VoiceReplyMessage
    # @param [Hash] attributes
    # @see 'spec/mp_weixin/models/reply_message_spec.rb'
    def reply_voice_message(attributes = {}, &block)
      reply_message = MpWeixin::VoiceReplyMessage.new(attributes)
      block.call(reply_message) if block_given?

      reply_message
    end

    # initialize an VideoReplyMessage
    # @param [Hash] attributes
    # @see 'spec/mp_weixin/models/reply_message_spec.rb'
    def reply_video_message(attributes = {}, &block)
      reply_message = MpWeixin::VideoReplyMessage.new(attributes)
      block.call(reply_message) if block_given?

      reply_message
    end

    # initialize an MusicReplyMessage
    # @param [Hash] attributes
    # @see 'spec/mp_weixin/models/reply_message_spec.rb'
    def reply_music_message(attributes = {}, &block)
      reply_message = MpWeixin::MusicReplyMessage.new(attributes)
      block.call(reply_message) if block_given?

      reply_message
    end

    # initialize an NewsReplyMessage
    # @param [Hash] attributes
    # @see 'spec/mp_weixin/models/reply_message_spec.rb'
    def reply_news_message(attributes = {}, &block)
      reply_message = MpWeixin::NewsReplyMessage.new(attributes)

      block.call(reply_message) if block_given?

      reply_message
    end
  end
end
