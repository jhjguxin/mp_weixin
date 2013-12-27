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
- 验证消息真实性 [DONE]
- 接收普通消息 [DONE]
- 接收事件推送 [DONE]
- 接收语音识别结果 [DONE]

### 发送消息

- 发送被动响应消息 [DONE]
- 发送客服消息 [DONE]

### 用户管理

- 分组管理接口 [DONE]
- 获取用户基本信息 [DONE]
- 获取关注者列表 [DONE]
- 获取用户地理位置 [TODO]
- 网页授权获取用户基本信息 [DONE] [prefer](https://github.com/jhjguxin/open_weixin/)
- 网页获取用户网络状态（JS接口）[NOPLAN]

### 自定义菜单

- 自定义菜单创建接口 [DONE]
- 自定义菜单查询接口 [DONE]
- 自定义菜单删除接口 [DONE]
- 自定义菜单事件推送 [DONE]

### 推广支持

- 生成带参数的二维码 [DONE]


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

TODO: Write usage instructions here


more detail pls check `spec/`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
