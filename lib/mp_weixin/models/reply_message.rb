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
      super
      @CreateTime ||= Time.now.to_i
    end

    def to_xml
      super.to_xml(:encoding => 'UTF-8', :indent => 0, :save_with => 0)
    end

    class << self
      def set_nested_attr(nested_attr_name)
        # define_method(:hi) { puts "Hello World!" }
        class_eval <<-STR
          def #{nested_attr_name}=(nested_attr = [])
            @#{nested_attr_name} = nested_attr.is_a?(#{nested_attr_name}) ? nested_attr : #{nested_attr_name}.new(nested_attr)
          end
        STR
      end
    end
  end

  class TextReplyMessage < ReplyMessage
    # include ActiveModel::Model

    attr_accessor :Content
    xml_accessor :Content, :cdata => true

    def initialize(attributes = {})
      super
      @MsgType ||= 'text'
    end
  end

  class Image
    include ActiveModel::Model
    include ROXML

    attr_accessor :MediaId
    xml_accessor :MediaId

    # other important functionality
  end

  class ImageReplyMessage < ReplyMessage
    attr_accessor :Image
    xml_accessor :Image, as: Image, :cdata => true

    set_nested_attr :Image
    def initialize(attributes = {})
      super
      @MsgType ||= 'image'
    end

  end

  class Voice
    include ActiveModel::Model
    include ROXML

    xml_accessor :MediaId

    # other important functionality
  end

  class VoiceReplyMessage < ReplyMessage
    attr_accessor :Voice
    xml_accessor :Voice, as: Voice, :cdata => true
    set_nested_attr :Voice

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
    attr_accessor :Video
    xml_accessor :Video, as: Video, :cdata => true
    set_nested_attr :Video

    def initialize(attributes = {})
      super
      @MsgType ||= 'video'
    end

  end

  class Music
    include ActiveModel::Model
    include ROXML

    attr_accessor :Title, :Description, :MusicUrl, :HQMusicUrl, :ThumbMediaId

    xml_accessor :Title, :cdata => true
    xml_accessor :Description, :cdata => true
    xml_accessor :MusicUrl, :cdata => true
    xml_accessor :HQMusicUrl, :cdata => true
    xml_accessor :ThumbMediaId, :cdata => true
  end

  class MusicReplyMessage < ReplyMessage
    attr_accessor :Music
    xml_accessor :Music, :as => Music
    set_nested_attr :Music

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
    set_nested_attr :Articles

    def initialize(attributes = {})
      super
      @MsgType ||= 'news'
    end

    def Articles=(attributes)
      _attributes = attributes.is_a?(Hash) ? attributes.deep_symbolize_keys[:item] : attributes.dup

      @Articles = _attributes.collect do |item_attr|

        if item_attr.is_a?(Item)
          item_attr
        else
         item_attr = item_attr.deep_symbolize_keys
         Item.new(item_attr)
        end
      end
    end
  end
end
