module MpWeixin
  module Interface

    # The Base class of API
    class Base
      def initialize(client)
        @client = client
      end

      def default_request_params
        access_token = @client.token.token
        #request_params = {"oauth_consumer_key" => self.id, "access_token" => access_token, "openid" => params["openid"], "oauth_version" => "2.a", "scope" => "all"}
        {"openid" => @client.id, "access_token" => access_token}
      end

      def request(verb, path, opts={}, &block)
        unless @client.is_authorized?
          raise "I can't find a valid access_token. Forgot to get it or expired?"
        end

        opts[:params] ||= {}
        opts[:params].merge!(default_request_params)
        opts = ActiveSupport::HashWithIndifferentAccess.new(opts)

        response = @client.token.request(verb, path, opts, &block)
        if response.error
          raise Error.new(response)
        end
        response
      end

      def get(path, opts={}, &block)
        request(:get, path, opts, &block)
      end

      def post(path, opts={}, &block)
        request(:post, path, opts, &block)
      end
    end

  end
end
