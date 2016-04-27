class FakeSshExecutioner
  class_attribute :return_value

  def self.start(ip, username, opt = {})
    if return_value.respond_to?(:call)
      return_value.call
    else
      return_value
    end
  end
end
