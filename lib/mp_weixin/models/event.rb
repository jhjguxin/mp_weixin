# encoding: utf-8
module MpWeixin
  # The MpWeixin::Message class
  #
  class Event
    include ActiveModel::Model
    attr_accessor :ToUserName, :FromUserName,
                    :CreateTime, :MsgType

    # Instantiate a new Message with a hash of attributes
    #
    # @param [Hash] attributes the attributes value
    def initialize(attributes = nil)
      # Dynamic attr_accessible
      # maybe cause secret problem
      singleton_class.class_eval do
        attr_accessor *attributes.keys
      end

      super
      @source = ActiveSupport::HashWithIndifferentAccess.new(attributes)
    end

    # same as @attributes CreateTime of an Message instance
    #
    # @return [Integer]
    def create_time
      self.CreateTime.to_i
    end
    # alias :CreateTime :create_time

    # convert create_time to an Time instance
    #
    # @return [Time]
    def created_at
      Time.at create_time rescue nil
    end

    class << self
      def from_xml(xml)
        begin
          hash = MultiXml.parse(xml)['xml']

          message = case hash['MsgType']
                      when 'event'
                        Event.new(hash)
                      else
                        # raise 'Unknown Message data'
                    end
        rescue
          logger.info('Unknown Message data #{xml}') if self.respond_to?(:logger)
        end
      end
    end
  end
end
