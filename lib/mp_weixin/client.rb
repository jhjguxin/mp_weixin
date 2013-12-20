module MpWeixin
  # The MpWeixin::Client class
  # reference to The OAuth2::Client class
  class Client
    attr_reader :id, :secret, :site
    attr_accessor :options, :token
    attr_writer :connection

    # Instantiate a new client using the
    # Client ID and Client Secret registered to your
    # weixin mp account.
    #
    # @param [String] app_id the app_id value
    # @param [String] app_secret the app_secret value
    # @param [Hash] opts the options to create the client with
    # @option opts [String] :site the site host provider to connection
    # @option opts [String] :authorize_url ('/oauth/authorize') absolute or relative URL path to the Authorization endpoint
    # @option opts [String] :token_url ('/oauth/token') absolute or relative URL path to the Token endpoint
    # @option opts [Hash] :connection_opts ({}) Hash of connection options to pass to initialize Faraday with
    # @option opts [Boolean] :raise_errors (true) whether or not to raise an MpWeixin::Error
    #  on responses with 400+ status codes
    # @yield [builder] The Faraday connection builder
    def initialize(app_id = nil, app_secret = nil, opts={}, &block)
      _opts = opts.dup
      @id = app_id || Config.app_id
      @secret = app_secret || Config.app_secret
      @site = _opts.delete(:site) || "https://api.weixin.qq.com/"
      ssl = _opts.delete(:ssl)
      @options = {:authorize_url    => '/oauth/authorize',
                  :token_url        => '/cgi-bin/token',
                  :token_method     => :post,
                  :connection_opts  => {},
                  :connection_build => block,
                  :raise_errors     => true}.merge(_opts)
      @options[:connection_opts][:ssl] = ssl if ssl
    end

    # Whether or not the client is authorized
    #
    # @return [Boolean]
    def is_authorized?
      !!token && !token.expired?
    end

    # Set the site host
    #
    # @param [String] the MpWeixin provider site host
    def site=(value)
      @connection = nil
      @site = value
    end

    # The Faraday connection object
    def connection
      @connection ||= begin
        conn = Faraday.new(site, options[:connection_opts])
        conn.build do |b|
          options[:connection_build].call(b)
        end if options[:connection_build]
        conn
      end
    end

    # Makes a request relative to the specified site root.
    #
    # @param [Symbol] verb one of :get, :post, :put, :delete
    # @param [String] url URL path of request
    # @param [Hash] opts the options to make the request with
    # @option opts [Hash] :params additional query parameters for the URL of the request
    # @option opts [Hash, String] :body the body of the request
    # @option opts [Hash] :headers http request headers
    # @option opts [Boolean] :raise_errors whether or not to raise an MpWeixin::Error on 400+ status
    def request(verb, url, opts={})
      url = self.connection.build_url(url, opts[:params]).to_s

      response = connection.run_request(verb, url, opts[:body], opts[:headers]) do |req|
        yield(req) if block_given?
      end
      response = Response.new(response, :parse => opts[:parse])

      case response.status
      when 301, 302, 303, 307
        opts[:redirect_count] ||= 0
        opts[:redirect_count] += 1
        return response if opts[:redirect_count] > options[:max_redirects]
        if response.status == 303
          verb = :get
          opts.delete(:body)
        end
        request(verb, response.headers['location'], opts)
      when 200..299, 300..399
        # on non-redirecting 3xx statuses, just return the response
        response
      when 400..599
        e = Error.new(response)
        raise e if opts.fetch(:raise_errors, options[:raise_errors])
        response.error = e
        response
      else
        raise Error.new(response), "Unhandled status code value of #{response.status}"
      end
    end

    # The authorize endpoint URL of the MpWeixin provider
    #
    # @param [Hash] params additional query parameters
    def authorize_url(params=nil)
      connection.build_url(options[:authorize_url], params).to_s
    end

    # The token endpoint URL of the MpWeixin provider
    #
    # @param [Hash] params additional query parameters
    def token_url(params=nil)
      connection.build_url(options[:token_url], params).to_s
    end

    # Initializes an AccessToken by making a request to the token endpoint
    #
    # @param [Hash] params a Hash of params for the token endpoint
    # @param [Hash] access token options, to pass to the AccessToken object
    # @param [Class] class of access token for easier subclassing MpWeixin::AccessToken
    # @return [AccessToken] the initalized AccessToken
    def get_token(params = {}, access_token_opts = {}, access_token_class = AccessToken)
      params = ActiveSupport::HashWithIndifferentAccess.new(params)
      params.reverse_merge!(grant_type: "client_credential", appid: id, secret: secret)

      opts = {:raise_errors => options[:raise_errors], :parse => params.delete(:parse)}
      if options[:token_method] == :post
        headers = params.delete(:headers)
        opts[:body] = params
        opts[:headers] =  {'Content-Type' => 'application/x-www-form-urlencoded'}
        opts[:headers].merge!(headers) if headers
      else
        opts[:params] = params
      end
      response = request(options[:token_method], token_url, opts)
      raise Error.new(response) if options[:raise_errors] && !(response.parsed.is_a?(Hash) && response.parsed['access_token'])
      @token = access_token_class.from_hash(self, response.parsed.merge(access_token_opts))
    end
  end
end
