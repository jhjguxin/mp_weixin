# encoding: utf-8
module MpWeixin
  module ResponseRule
    # '接收普通消息', '接收事件推送', '接收语音识别结果'
    #
    def handle_request(request, &block)
      request.body.rewind  # in case someone already read it
      data = request.body.read
      message = Message.from_xml(data)

      logger.info "Hey, one request from '#{request.url}' been detected, and content is #{message.as_json}"

      if message.present?
        handle_message(request, message)
        response_message(request, message, &block)
      else
        halt 400, 'unknown message'
      end
    end

    # handle corrent data post from weixin
    #
    # please @rewrite me
    def handle_message(request, message)
      #
    end

    # 发送被动响应消息'
    #
    # please @rewrite me
    #
    #
    # can rely with instance of those class eg, TextReplyMessage, ImageReplyMessage, VoiceReplyMessage
    # VideoReplyMessage, MusicReplyMessage, NewsReplyMessage
    # quickly generate reply content through call 'reply_#{msg_type}_message(attributes).to_xml' @see 'spec/mp_weixin/server_helper_spec.rb'
    #
    def response_message(request, message, &block)
      if block_given?
        block.call(request, message)
      end

      # reply with
      # reply_#{msg_type}_message(attributes).to_xml
    end
  end
end
