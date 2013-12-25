# encoding: utf-8
module MpWeixin
  module Interface

    # 分组管理
    #
    # 开发者可以使用接口，对公众平台的分组进行查询、创建、修改操作，也可以使用接口在需要时移动用户到某个分组。
    class Group < Base

      # 创建分组:
      #
      # 一个公众账号，最多支持创建500个分组。 接口调用请求说明
      #
      #    http请求方式: POST（请使用https协议）
      #    https://api.weixin.qq.com/cgi-bin/groups/create?access_token=ACCESS_TOKEN
      #    POST数据格式：json
      #    POST数据例子：{"group":{"name":"test"}}
      #
      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E5%88%86%E7%BB%84%E7%AE%A1%E7%90%86%E6%8E%A5%E5%8F%A3#.E5.88.9B.E5.BB.BA.E5.88.86.E7.BB.84
      def create(arg = nil)
        if arg.present?
          opts = arg.is_a?(Hash) ? arg : {group: {name: arg}}
          opts = opts.to_json

          post '/cgi-bin/groups/create', :body => opts, :params => default_request_params
        end
      end

      # 查询所有分组
      #
      #    http请求方式: GET（请使用https协议）
      #    https://api.weixin.qq.com/cgi-bin/groups/get?access_token=ACCESS_TOKEN
      #
      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E5%88%86%E7%BB%84%E7%AE%A1%E7%90%86%E6%8E%A5%E5%8F%A3#.E6.9F.A5.E8.AF.A2.E6.89.80.E6.9C.89.E5.88.86.E7.BB.84
      def get_groups(opts = {})
        get '/cgi-bin/groups/get', :params => opts.merge(default_request_params)
      end

      # 查询用户所在分组
      #
      # 通过用户的OpenID查询其所在的GroupID。 接口调用请求说明
      #
      #    http请求方式: POST（请使用https协议）
      #    https://api.weixin.qq.com/cgi-bin/groups/getid?access_token=ACCESS_TOKEN
      #    POST数据格式：json
      #    POST数据例子：{"openid":"od8XIjsmk6QdVTETa9jLtGWA6KBc"}
      #
      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E5%88%86%E7%BB%84%E7%AE%A1%E7%90%86%E6%8E%A5%E5%8F%A3#.E6.9F.A5.E8.AF.A2.E7.94.A8.E6.88.B7.E6.89.80.E5.9C.A8.E5.88.86.E7.BB.84
      def getid(opts = {})
        post '/cgi-bin/groups/getid', :body => opts.to_json, :params => default_request_params
      end

      # 修改分组名
      #
      # 接口调用请求说明
      #
      #    http请求方式: POST（请使用https协议）
      #    https://api.weixin.qq.com/cgi-bin/groups/update?access_token=ACCESS_TOKEN
      #    POST数据格式：json
      #    POST数据例子：{"group":{"id":108,"name":"test2_modify2"}}
      #
      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E5%88%86%E7%BB%84%E7%AE%A1%E7%90%86%E6%8E%A5%E5%8F%A3#.E4.BF.AE.E6.94.B9.E5.88.86.E7.BB.84.E5.90.8D
      def update(opts = {})
        post '/cgi-bin/groups/update', :body => opts.to_json, :params => default_request_params
      end

      # 移动用户分组
      #
      # 接口调用请求说明
      #
      #    http请求方式: POST（请使用https协议）
      #    https://api.weixin.qq.com/cgi-bin/groups/members/update?access_token=ACCESS_TOKEN
      #    POST数据格式：json
      #    POST数据例子：{"openid":"oDF3iYx0ro3_7jD4HFRDfrjdCM58","to_groupid":108}
      #
      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E5%88%86%E7%BB%84%E7%AE%A1%E7%90%86%E6%8E%A5%E5%8F%A3#.E4.BF.AE.E6.94.B9.E5.88.86.E7.BB.84.E5.90.8D
      def update_memgers(opts = {})
        post '/cgi-bin/groups/members/update', :body => opts.to_json, :params => default_request_params
      end
    end
  end
end
