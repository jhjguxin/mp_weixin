# encoding: utf-8
require "spec_helper"

describe MpWeixin::ServerHelper do
  include MpWeixin::ServerHelper

  let(:config) { MpWeixin::Config }
  let(:token) { config.token }
  let(:timestamp) { "1388028695" } #{ "#{Time.now.to_i}" }
  let(:nonce) { "121212121" }
  let(:signature)  { "9dc548e8c7fe32ac53f887e834a8c719a73cafc3" }# { generate_signature(token, timestamp, nonce) }
  let(:incorrent_signature) { SecureRandom.hex(64) }

  context "#generate_signature" do
    it "should generate an signature" do
      generate_signature(token, timestamp, nonce).should be_a(String)
    end
  end

  context "#valid_signature?" do
    it "should return true when every are well" do
      expect(valid_signature?(signature, timestamp, nonce)).to be_true
    end

    it "should return false if valid with incorrent_signature" do
      expect(valid_signature?(incorrent_signature, timestamp, nonce)).to be_false
    end
  end
end
