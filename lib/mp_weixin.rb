require 'rubygems'
require 'bundler/setup'

if defined?(Bundler)
  Bundler.require
end

require 'faraday'
require 'active_support/all'

require "mp_weixin/version"
require "mp_weixin/config"
require "mp_weixin/error"

# require models

# require client

## require client dependence
require "mp_weixin/response"
require "mp_weixin/access_token"

## require interface
require "mp_weixin/interface/base"
require "mp_weixin/interface/message"
require "mp_weixin/interface/menu"
require "mp_weixin/interface/promotion"

require "mp_weixin/client"

# require server
