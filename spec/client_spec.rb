require "spec_helper"

describe MpWeixin::Client do
  let(:client) { MpWeixin::Client.new }

  let(:access_token) { double(:app_id => "app_id", :app_secret => "app_secret") }

  before(:each) do
    client.stub(:access_token).and_return(access_token)
  end

  context "#initialize config" do
    it "should have correct site" do
      client.site.should eq("https://api.weixin.qq.com/")
    end

    # it "should have correct authorize url" do
    #   client.options[:authorize_url].should eq('/oauth/authorize')
    # end

    it "should have correct token url" do
      client.options[:token_url].should eq('/cgi-bin/token')
    end

    it 'is_authorized? should been false' do
      expect(subject.is_authorized?).to eq(false)
    end
  end

  context "#taken_code" do
    let(:code) {'sushi'}
    let(:json_token) {MultiJson.encode(:expires_in => 7200, :access_token => 'salmon')}

    let(:client) do
      MpWeixin::Client.new do |builder|
        builder.request :url_encoded
        builder.adapter :test do |stub|
          stub.get("/cgi-bin/token") do |env|
             [200, {'Content-Type' => 'application/json'}, json_token]
          end
          stub.post('/cgi-bin/token') do |env|
              [200, {'Content-Type' => 'application/json'}, json_token]
          end
        end
      end
    end

    subject do
      client.get_token
      client
    end


    it "returns AccessToken with #token" do
      expect(subject.token.token).to eq('salmon')
    end

    it 'is_authorized? should been true' do
      expect(subject.is_authorized?).to eq(true)
    end
  end
end
