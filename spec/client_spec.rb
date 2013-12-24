require "spec_helper"

describe MpWeixin::Client do
  let(:client) { MpWeixin::Client.new }
  let(:access_token) { 'ACCESS_TOKEN' }
  let(:token_hash) { {"expires_in" => "7200", "access_token" => access_token} }


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

  context "get_token_from_hash" do
    subject { client.get_token_from_hash(token_hash) }

    it "return token the initalized AccessToken" do
      expect(subject).to be_a(MpWeixin::AccessToken)
    end

    it "return token with provide access_token" do
      expect(subject.token).to eq(access_token)
    end
  end

  context "#from_hash" do
    subject { MpWeixin::Client.from_hash(token_hash) }

    it "return client the initalized Client" do
      expect(subject).to be_a(MpWeixin::Client)
    end

    it "return token with provide access_token" do
      expect(subject.token.token).to eq(access_token)
    end

    it 'is_authorized? should been true' do
      expect(subject.is_authorized?).to eq(true)
    end
  end
end
