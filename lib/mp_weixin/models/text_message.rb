class TextMessage
  include DataMapper::Resource

  property :id,         Serial
  property :to_user_name,  String
  property :from_user_name,      String
  property :msg_type,        String, :default  => "text"
  property :content,       Text
  property :create_time,       Text
  property :func_flag,      Integer, :default  => 0
  
  def weixin_xml
    template_xml = <<Text
<xml>
 <ToUserName><![CDATA[#{to_user_name}]]></ToUserName>
 <FromUserName><![CDATA[#{from_user_name}]]></FromUserName>
 <CreateTime>#{create_time.to_i}</CreateTime>
 <MsgType><![CDATA[#{msg_type}]]></MsgType>
 <Content><![CDATA[#{content}]]></Content>
 <FuncFlag><![CDATA[#{func_flag}]]></FuncFlag>
</xml> 
Text
  end
end
