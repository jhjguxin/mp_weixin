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
require "mp_weixin/response"
require "mp_weixin/access_token"

# require interface

require "mp_weixin/client"

# require server
