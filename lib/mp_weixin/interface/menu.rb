# encoding: utf-8
module MpWeixin
  module Interface

    # 自定义菜单
    class Menu < Base

      # 自定义菜单创建接口:
      #
      # 一个公众账号，最多支持创建500个分组。 接口调用请求说明
      #
      #    {
      #      "button":[
      #      {
      #         "type":"click",
      #         "name":"今日歌曲",
      #         "key":"V1001_TODAY_MUSIC"
      #      },
      #      {
      #         "type":"click",
      #         "name":"歌手简介",
      #         "key":"V1001_TODAY_SINGER"
      #      },
      #      {
      #         "name":"菜单",
      #         "sub_button":[
      #         {
      #             "type":"view",
      #             "name":"搜索",
      #             "url":"http://www.soso.com/"
      #          },
      #          {
      #             "type":"view",
      #             "name":"视频",
      #             "url":"http://v.qq.com/"
      #          },
      #          {
      #             "type":"click",
      #             "name":"赞一下我们",
      #             "key":"V1001_GOOD"
      #          }]
      #      }]
      #    }
      #
      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E8%87%AA%E5%AE%9A%E4%B9%89%E8%8F%9C%E5%8D%95%E5%88%9B%E5%BB%BA%E6%8E%A5%E5%8F%A3
      def create(opts = nil)
        opts = opts.to_json if opts.is_a?(Hash)

        post '/cgi-bin/menu/create', :body => opts, :params => default_request_params
      end

      # 自定义菜单查询接口
      # http请求方式：GET
      #   https://api.weixin.qq.com/cgi-bin/menu/get?access_token=ACCESS_TOKEN
      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E8%87%AA%E5%AE%9A%E4%B9%89%E8%8F%9C%E5%8D%95%E6%9F%A5%E8%AF%A2%E6%8E%A5%E5%8F%A3
      def get_menus(opts = {})
        get '/cgi-bin/menu/get', :params => opts.merge(default_request_params)
      end

      # 自定义菜单查询接口
      # http请求方式：GET
      #   https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=ACCESS_TOKEN
      # @see http://mp.weixin.qq.com/wiki/index.php?title=%E8%87%AA%E5%AE%9A%E4%B9%89%E8%8F%9C%E5%8D%95%E5%88%A0%E9%99%A4%E6%8E%A5%E5%8F%A3
      def delete(opts = {})
        get '/cgi-bin/menu/delete', :params => opts.merge(default_request_params)
      end

      # 自定义菜单事件推送
      # 用户点击自定义菜单后，如果菜单按钮设置为click类型，则微信会把此次点击事件推送给开发者，注意view类型（跳转到URL）的菜单点击不会上报。
    end
  end
end
