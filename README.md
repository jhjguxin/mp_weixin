# MpWeixin

A wrapper for weiXin MP platform

## Installation

Add this line to your application's Gemfile:

    gem 'mp_weixin'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mp_weixin

## Functions & Features

### 基础支持

- 获取access token [TODO]
- 全局返回码说明 [TODO]
- [接口频率限制说明](http://mp.weixin.qq.com/wiki/index.php?title=%E6%8E%A5%E5%8F%A3%E9%A2%91%E7%8E%87%E9%99%90%E5%88%B6%E8%AF%B4%E6%98%8E) [NOPLAN]
- 上传下载多媒体文件 [TODO]

### 接收消息
- 验证消息真实性 [TODO]
- 接收普通消息 [TODO]
- 接收事件推送 [TODO]
- 接收语音识别结果 [TODO]

### 发送消息

- 发送被动响应消息 [TODO]
- 发送客服消息 [TODO]

### 用户管理

- 分组管理接口 [TODO]
- 获取用户基本信息 [TODO]
- 获取关注者列表 [TODO]
- 获取用户地理位置 [TODO]
- 网页授权获取用户基本信息 [NOPLAN]
- 网页获取用户网络状态（JS接口）[NOPLAN]

### 自定义菜单

- 自定义菜单创建接口 [TODO]
- 自定义菜单查询接口 [TODO]
- 自定义菜单删除接口 [TODO]
- 自定义菜单事件推送 [TODO]

### 推广支持

- 生成带参数的二维码 [NOPLAN]


### The Structure

```shell
$ tree lib/ -L 3
lib/
├── config
│   └── mp_weixin_error.yml
├── mp_weixin
│   ├── client.rb
│   ├── interface
│   ├── models
│   ├── server.rb
│   └── version.rb
└── mp_weixin.rb
```

### client:

which initiate with an `app_id` and `app_secret` who have ability to request interface provider by 'https://api.weixin.qq.com'. Of course at first you must been authorize. Those include '发送客服消息', '用户管理', '自定义菜单'.

### server

It's a web service, used to receive all the http request from 'weixin server', and give and rigth response. those response include '接收消息', '发送被动响应消息'.

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
