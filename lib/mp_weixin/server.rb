# encoding: utf-8
module MpWeixin
  class Server < Sinatra::Base
    configure :production, :development do
      enable :logging

      set :haml, { :ugly=>true }
      set :clean_trace, true
      Dir.mkdir('log') unless File.exist?('log')

      file = File.new("./log/mp_weixin_#{settings.environment}.log", 'a+')
      file.sync = true
      use Rack::CommonLogger, file
    end

    helpers MpWeixin::ServerHelper, MpWeixin::ResponseRule


    before '/' do
      unless valid_signature?(signature = params[:signature], timestamp = params[:timestamp], nonce= params[:nonce] )
        halt 401,{'Content-Type' => 'text/plain'}, 'go away!'
      end
    end

    # 验证消息真实性
    #
    # 通过检验signature对请求进行校验（下面有校验方式）。若确认此次GET请求来自微信服务器，请原样返回echostr参数内容，则接入生效，成为开发者成功，否则接入失败
    # eg curl http://localhost:4567/?nonce=121212121&signature=9dc548e8c7fe32ac53f887e834a8c719a73cafc3&timestamp=1388028695&echostr=22222222222222222
    get '/' do
      params[:echostr]
    end

    # '接收普通消息', '发送被动响应消息', '接收事件推送', '接收语音识别结果'
    post "/" do
      content_type 'text/xml'
      handle_request(request)
    end
  end
end
