class Message
  include ActiveModel::Model
  def initialize(attributes)
    super
    @source = ActiveSupport::HashWithIndifferentAccess.new(attributes)
  end

  def create_time
    self.CreateTime.to_i
  end
  # alias :CreateTime :create_time

  def msg_id
    self.MsgId.to_i
  end
end
