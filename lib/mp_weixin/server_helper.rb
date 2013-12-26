# encoding: utf-8
module MpWeixin
  module ServerHelper

    # generate a signature string through sha1 encrypt token, timestamp, nonce .
    #
    # @param [String] token the token value
    # @param [String] timestamp the timestamp value from weixin
    # @param [String] nonce the random num from weixin
    #
    #    加密/校验流程如下：
    #    1. 将token、timestamp、nonce三个参数进行字典序排序
    #    2. 将三个参数字符串拼接成一个字符串进行sha1加密
    #    3. 开发者获得加密后的字符串可与signature对比，标识该请求来源于微信
    #
    # @return [String]
    def generate_signature(token, timestamp, nonce)
      signature_content = [token.to_s, timestamp.to_s, nonce.to_s].sort.join("")
      Digest::SHA1.hexdigest(signature_content)
    end

    # Whether or not the signature is eql with local_signature
    #
    # @param [String] signature the signature value need validate
    # @param [String] timestamp the timestamp value from weixin
    # @param [String] nonce the nonce value
    #
    # @return [Boolean]
    def valid_signature?(signature, timestamp, nonce)
      token = Config.token

      local_signature = generate_signature(token,timestamp,nonce)
      local_signature.eql? signature
    end
  end
end
