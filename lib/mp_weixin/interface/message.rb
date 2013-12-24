# encoding: utf-8
module MpWeixin
  module Interface

    # 发送消息
    class Message < Base
      # 发送客服消息
      # 文本消息:
      #
      # {
      #    "touser":"OPENID",
      #    "msgtype":"text",
      #    "text":
      #    {
      #         "content":"Hello World"
      #    }
      # }
      #
      # 发送图片消息:
      # {
      #    "touser":"OPENID",
      #    "msgtype":"image",
      #    "image":
      #    {
      #      "media_id":"MEDIA_ID"
      #    }
      # }
      # etc
      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E5%8F%91%E9%80%81%E5%AE%A2%E6%9C%8D%E6%B6%88%E6%81%AF
      def custom_send(opts = nil)
        opts = opts.to_json if opts.is_a?(Hash)

        post '/cgi-bin/message/custom/send', :body => opts, :params => default_request_params
      end
    end
  end
end
