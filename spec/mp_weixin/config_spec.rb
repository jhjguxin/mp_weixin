# encoding: utf-8
require "spec_helper"

describe MpWeixin::Config do
  let(:config) { MpWeixin::Config }

  context "#initialize config" do
    it "should have correct app_id" do
      config.app_id.should eq("12341432134")
    end

    it "should have correct app_secret" do
      config.app_secret.should eq('app_secret')
    end

    it "should have correct url" do
      config.url.should eq('http://www.example.com')
    end

    it "should have correct token" do
      config.token.should eq('secret')
    end
  end
end
