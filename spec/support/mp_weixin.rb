# encoding: utf-8
#bellow code to initialize the BabyTime
MpWeixinConfig = YAML.load_file("./spec/support/weixin.yml")["test"].symbolize_keys
MpWeixin::Config.app_id = MpWeixinConfig[:app_id]
MpWeixin::Config.app_secret = MpWeixinConfig[:app_secret]
MpWeixin::Config.url = MpWeixinConfig[:url]
MpWeixin::Config.token = MpWeixinConfig[:token]
