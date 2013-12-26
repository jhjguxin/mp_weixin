# encoding: utf-8

module MpWeixin
  class ReplyMessage
    include ActiveModel::Model
    include ROXML

    xml_name :xml
    #xml_convention :camelcase

    attr_accessor :ToUserName, :FromUserName,
                    :CreateTime, :MsgType

    xml_accessor :ToUserName, :cdata => true
    xml_accessor :FromUserName, :cdata => true
    xml_reader :CreateTime, :as => Integer
    xml_reader :MsgType, :cdata => true

    def initialize(attributes = {})
      @CreateTime ||= Time.now.to_i
    end

    def to_xml
      super.to_xml(:encoding => 'UTF-8', :indent => 0, :save_with => 0)
    end
  end

  class TextReplyMessage < ReplyMessage
    attr_accessor :Content
    xml_accessor :Content, :cdata => true

    def initialize(attributes = {})
      super
      @MsgType ||= 'text'
    end
  end

  class Image
    include ROXML

    xml_accessor :MediaId

    # other important functionality
  end

  class ImageReplyMessage < ReplyMessage
    attr_accessor :MediaId
    xml_accessor :MediaId, as: Image, :cdata => true

    def initialize(attributes = {})
      super
      @MsgType ||= 'image'
    end
  end

  class Voice
    include ROXML

    xml_accessor :MediaId

    # other important functionality
  end

  class VoiceReplyMessage < ReplyMessage
    attr_accessor :MediaId
    xml_accessor :MediaId, as: Voice, :cdata => true

    def initialize(attributes = {})
      super
      @MsgType ||= 'voice'
    end
  end

  class Video
    include ActiveModel::Model
    include ROXML

    attr_accessor :MediaId, :Title, :Description

    xml_accessor :MediaId, :cdata => true
    xml_accessor :Title, :cdata => true
    xml_accessor :Description, :cdata => true

  end

  class VideoReplyMessage < ReplyMessage
    attr_accessor :MediaId
    xml_accessor :MediaId, as: Video, :cdata => true

    def initialize(attributes = {})
      super
      @MsgType ||= 'video'
    end
  end

  class Music
    include ActiveModel::Model
    include ROXML

    attr_accessor :Title, :Description, :MusicUrl, :HQMusicUrl

    xml_accessor :Title, :cdata => true
    xml_accessor :Description, :cdata => true
    xml_accessor :MusicUrl, :cdata => true
    xml_accessor :HQMusicUrl, :cdata => true
  end

  class MusicReplyMessage < ReplyMessage
    attr_accessor :Music
    xml_accessor :Music, :as => Music

    def initialize(attributes = {})
      super
      @MsgType ||= 'music'
    end
  end

  class Item
    include ActiveModel::Model
    include ROXML

    attr_accessor :Title, :Description, :PicUrl, :Url
    xml_accessor :Title, :cdata => true
    xml_accessor :Description, :cdata => true
    xml_accessor :PicUrl, :cdata => true
    xml_accessor :Url, :cdata => true
  end

  class NewsReplyMessage < ReplyMessage
    attr_accessor :ArticleCount, :Articles
    xml_accessor :ArticleCount, :as => Integer
    xml_accessor :Articles, :as => [Item], :in => 'Articles', :from => 'item'

    def initialize(attributes = {})
      super
      @MsgType ||= 'news'
    end
  end
end
