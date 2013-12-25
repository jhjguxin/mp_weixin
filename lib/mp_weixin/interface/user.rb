# encoding: utf-8
module MpWeixin
  module Interface

    # 获取用户基本信息 & 获取关注者列表
    #
    # 在关注者与公众号产生消息交互后，公众号可获得关注者的OpenID（加密后的微信号，每个用户对每个公众号的OpenID是唯一的。对于不同公众号，同一用户的openid不同）。公众号可通过本接口来根据OpenID获取用户基本信息，包括昵称、头像、性别、所在城市、语言和关注时间。
    class User < Base

      # 获取用户基本信息:
      #
      # 开发者可通过OpenID来获取用户基本信息。请使用https协议。
      #
      #    接口调用请求说明
      #    http请求方式: GET
      #    https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID
      #
      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E8%8E%B7%E5%8F%96%E7%94%A8%E6%88%B7%E5%9F%BA%E6%9C%AC%E4%BF%A1%E6%81%AF
      def info(opts = {})
        get '/cgi-bin/user/info', :params => opts.merge(default_request_params)
      end

      # 获取关注者列表
      #
      # 公众号可通过本接口来获取帐号的关注者列表，关注者列表由一串OpenID（加密后的微信号，每个用户对每个公众号的OpenID是唯一的）组成。一次拉取调用最多拉取10000个关注者的OpenID，可以通过多次拉取的方式来满足需求。
      #
      #   http请求方式: GET（请使用https协议）
      #   https://api.weixin.qq.com/cgi-bin/user/get?access_token=ACCESS_TOKEN&next_openid=NEXT_OPENID
      #
      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E8%8E%B7%E5%8F%96%E5%85%B3%E6%B3%A8%E8%80%85%E5%88%97%E8%A1%A8
      def get_users(opts = {})
        get '/cgi-bin/user/get', :params => opts.merge(default_request_params)
      end

      # 网页授权获取用户基本信息
      # [prefer](https://github.com/jhjguxin/open_weixin/)
    end
  end
end
