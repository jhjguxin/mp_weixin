module MpWeixin
  module Config

    def self.app_id= (val)
      @@app_id = val
    end

    def self.app_id
      @@app_id
    end

    def self.app_secret= (val)
      @@app_secret = val
    end

    def self.app_secret
      @@app_secret
    end

    def self.url= (val)
      @@url = val
    end

    def self.url
      @@url
    end

    def self.token= (val)
      @@token = val
    end

    def self.token
      @@token
    end
  end
end
