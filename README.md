# MpWeixin

A wrapper for weiXin MP platform

[![Gem Version](https://badge.fury.io/rb/mp_weixin.png)][gem]
[![Build Status](https://travis-ci.org/jhjguxin/mp_weixin.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/jhjguxin/mp_weixin.png?travis)][gemnasium]
[![Code Climate](https://codeclimate.com/github/jhjguxin/mp_weixin.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/jhjguxin/mp_weixin/badge.png?branch=master)][coveralls]

## Installation

Add this line to your application's Gemfile:

    gem 'mp_weixin'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mp_weixin

## Functions & Features

### 基础支持

- 获取access token [DONE]
- 全局返回码说明 [TODO]
- [接口频率限制说明](http://mp.weixin.qq.com/wiki/index.php?title=%E6%8E%A5%E5%8F%A3%E9%A2%91%E7%8E%87%E9%99%90%E5%88%B6%E8%AF%B4%E6%98%8E) [NOPLAN]
- 上传下载多媒体文件 [TODO]

### 接收消息
- 验证消息真实性 [DONE] [prefer](spec/mp_weixin/server_spec.rb)
- 接收普通消息 [DONE] [prefer](spec/mp_weixin/server_helper_spec.rb)
- 接收事件推送 [DONE] [prefer](spec/mp_weixin/server_helper_spec.rb)
- 接收语音识别结果 [DONE] [prefer](spec/mp_weixin/server_helper_spec.rb)

### 发送消息

- 发送被动响应消息 [DONE] [prefer](spec/mp_weixin/server_helper_spec.rb)
- 发送客服消息 [DONE] [prefer](spec/mp_weixin/interface/message_spec.rb)

### 用户管理

- 分组管理接口 [DONE] [prefer](spec/mp_weixin/interface/user_spec.rb)
- 获取用户基本信息 [DONE] [prefer](spec/mp_weixin/interface/user_spec.rb)
- 获取关注者列表 [DONE] [prefer](spec/mp_weixin/interface/user_spec.rb)
- 获取用户地理位置 [DONE] [prefer](spec/mp_weixin/models/event.rb)
- 网页授权获取用户基本信息 [DONE] [prefer](https://github.com/jhjguxin/open_weixin/)
- 网页获取用户网络状态（JS接口）[NOPLAN]

### 自定义菜单

- 自定义菜单创建接口 [DONE] [prefer](spec/mp_weixin/interface/menu_spec.rb)
- 自定义菜单查询接口 [DONE] [prefer](spec/mp_weixin/interface/menu_spec.rb)
- 自定义菜单删除接口 [DONE] [prefer](spec/mp_weixin/interface/menu_spec.rb)
- 自定义菜单事件推送 [DONE] [prefer](spec/mp_weixin/interface/menu_spec.rb)

### 推广支持

- 生成带参数的二维码 [DONE] [prefer](spec/mp_weixin/interface/promotion_spec.rb)


## The Structure

```shell
$ tree lib/ -L 3
lib/
├── config
│   └── mp_weixin_error.yml
├── mp_weixin
│   ├── access_token.rb
│   ├── client.rb
│   ├── config.rb
│   ├── error.rb
│   ├── interface
│   │   ├── base.rb
│   │   ├── group.rb
│   │   ├── menu.rb
│   │   ├── message.rb
│   │   ├── promotion.rb
│   │   └── user.rb
│   ├── models
│   │   ├── event.rb
│   │   ├── message.rb
│   │   └── reply_message.rb
│   ├── response.rb
│   ├── response_rule.rb
│   ├── server_helper.rb
│   ├── server.rb
│   └── version.rb
└── mp_weixin.rb
```

### client:

which initiate with an `app_id` and `app_secret` who have ability to request interface provider by 'https://api.weixin.qq.com'. Of course at first you must been authorize. Those include `发送客服消息`, `用户管理`, `自定义菜单`.

### server

It's a web service, used to receive all the http request from 'weixin server', and give and rigth response. those response include `接收消息`, `发送被动响应消息`.

want it should been like?

1.  first it should been a web service, it should have ability to '验证消息真实性', '接收普通消息
', '发送被动响应消息', '接收事件推送', '接收语音识别结果'.
2.  then I want it should can match some custom rules(like rails route)
3.  all of those rule's return will response to 'https://api.weixin.qq.com'

### models

some base data model used by [mp_weixin] eg `message`, `event`. Those model should have some usefully method been defined.

## Usage

- [server](lib/mp_weixin/server.rb)
- [client](lib/mp_weixin/client.rb)

### how boot mp_weixin

config `mp_weixin.yml` (eg `spec/support/weixin.yml`)

```yml
defaults: &defaults
  app_id: "12341432134"
  app_secret: "app_secret"
  url: "http://www.example.com"
  token: "secret"

development:
  <<: *defaults
production:
  <<: *defaults
test:
  <<: *defaults
```

initializer the MpWeixin (eg `spec/support/mp_weixin.rb`)

### launch `MpWeixin::Server`

create file `config.ru`

```ruby
require 'rubygems'
require 'bundler'

Bundler.require

# require 'mp_weixin'

run MpWeixin::Server
# rackup config.ru
```

### request weixin api

through `MpWeixin::Client` module request some api interface at 'weixin'

```ruby
# initalize and get new access_token
client = MpWeixin::Client.new
client.get_token
# initalize with exists access_token
token_hash = {"expires_in" => "7200", "access_token" => access_token}
client = MpWeixin::Client.from_hash(token_hash)

client.menu.get_menus
# more detail check 'spec/mp_weixin/interface/'
```

#### demo how guanxi use MpWeixin::Client

```ruby
# encoding: utf-8
class WechatClient
  include Mongoid::Document
  include Mongoid::Timestamps

  field :access_token, type: String
  field :expires_at, type: Integer

  class << self
    attr_accessor :wechat_client

    def get_access_token
      wechat_client = self.first || self.new

      {
        access_token: wechat_client.access_token,
        expires_at: wechat_client.expires_at.try(:to_i)
      }.keep_if{|_, v| v.present?}
    end
    def set_access_token(access_token, expires_at)
      wechat_client = self.first || self.new

      wechat_client.update_attributes(
                                             access_token: access_token,
                                             expires_at: expires_at
                                           )
    end

    # return an instance of MpWeixin#client with 'is_authorized?' is true
    #
    # client = WechatClient.this_client
    # client.message.custom_send(touser: "ozIMPt8wb8I8iYm-IjD1DHP-IQ9s", msgtype: "text", text: {content: "hey, we found you!"})
    def this_client
      unless @wechat_client.try("is_authorized?")
        @wechat_client = fresh_client
      end

      @wechat_client
    end

    def fresh_client
      token_hash = WechatClient.get_access_token
      expires_at_time = Time.at(token_hash[:expires_at]) rescue 2.hours.from_now

      if token_hash[:access_token].present? and (expires_at_time > Time.now)
        client = MpWeixin::Client.from_hash(token_hash)
      else
        client = MpWeixin::Client.new
        client.get_token

        WechatClient.set_access_token(client.token.token, client.token.expires_at)
      end

      client
    end
  end
end
```

### start weixin mp server

mount with Rails application

```ruby
# /app/services/wechat/response_rule.rb
# encoding: utf-8
module ResponseRule
  # handle corrent data post from weixin
  #
  # please @rewrite me
  def handle_message(request, message)
    #
    logger.info "Hey, one request from '#{request.url}' been detected, and content is #{message.as_json}"
    # did you want save this message ???
  end

  def response_text_message(request, message)
    case message.Content
      when /greet/
        reply_message = message.reply_text_message({Content: "whosyourdaddy!"})
        logger.info "response with #{reply_message.to_xml}"
      else
        reply_message = message.reply_text_message({Content: "hey, guy you are welcome!"})
        logger.info "response with #{reply_message.to_xml}"
    end
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
    send("response_#{message.MsgType}_message", request, message)

    # reply with
    # reply_#{msg_type}_message(attributes).to_xml
  end
end

# load custom response_rule
class MpWeixin::Server
  helpers ResponseRule
end
```

```ruby
# routes.rb
Gxservice::Application.routes.draw do
  require "mp_weixin"
  require "#{Rails.root}/app/services/wechat/response_rule"
  mount MpWeixin::Server, :at => '/weixin'
end
```

more detail pls check `spec/`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
