# encoding: utf-8
module MpWeixin
  module Interface

    # 推广支持 生成带参数的二维码
    class Promotion < Base

      # 创建二维码ticket:
      #
      # 临时二维码请求说明
      # http请求方式: POST
      # URL: https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=TOKEN
      # POST数据格式：json
      # POST数据例子：{"expire_seconds": 1800, "action_name": "QR_SCENE", "action_info": {"scene": {"scene_id": 123}}}
      # 永久二维码请求说明
      # http请求方式: POST
      # URL: https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=TOKEN
      # POST数据格式：json
      # POST数据例子：{"action_name": "QR_LIMIT_SCENE", "action_info": {"scene": {"scene_id": 123}}}
      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E7%94%9F%E6%88%90%E5%B8%A6%E5%8F%82%E6%95%B0%E7%9A%84%E4%BA%8C%E7%BB%B4%E7%A0%81
      def create(opts = nil)
        opts = opts.to_json if opts.is_a?(Hash)

        # http://rubydoc.info/gems/faraday/0.5.3/Faraday/Request
        post '/cgi-bin/qrcode/create', :body => opts, :params => default_request_params
      end

      # 自定义菜单查询接口
      # HTTP GET请求（请使用https协议）
      # https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=TICKET
      # 提醒：TICKET记得进行UrlEncode

      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E7%94%9F%E6%88%90%E5%B8%A6%E5%8F%82%E6%95%B0%E7%9A%84%E4%BA%8C%E7%BB%B4%E7%A0%81
      def showqrcode(ticket = nil)
        if ticket.present?
          opts = {ticket: ticket}
          get '/cgi-bin/showqrcode', :params => opts.merge(default_request_params) do |req|
            req.url 'https://mp.weixin.qq.com/cgi-bin/showqrcode', default_request_params
            req
          end
        end
      end

    end
  end
end
