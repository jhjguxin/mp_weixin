require 'rack/test'
module RSpecMixin
  include Rack::Test::Methods

  def app
    MpWeixin::Server
  end
end
