# encoding: utf-8

require 'rubygems'
require 'bundler/setup'

if defined?(Bundler)
  Bundler.require
end

require 'roxml'
require 'multi_xml'
require 'ostruct'

require 'faraday'
require 'active_model'
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
require "mp_weixin/interface/group"
require "mp_weixin/interface/user"

require "mp_weixin/client"

# require server
require 'sinatra'
require 'digest/md5'
require 'rexml/document'

# include base class Message
# and some children class TextMessage, ImageMessage, LocationMessage,
# LinkMessage, VoiceMessage, VideoMessage
require 'mp_weixin/models/message'
require 'mp_weixin/models/event'
require 'mp_weixin/models/reply_message'
# require 'mp_weixin/models/location_message'

## require helpers
require 'mp_weixin/server_helper'
require 'mp_weixin/response_rule'

require 'mp_weixin/server'
