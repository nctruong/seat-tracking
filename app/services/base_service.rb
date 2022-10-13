class BaseService
  attr_reader :errors

  def initialize(*_params)
    @errors = []
  end

  def self.call(*args)
    service = new(*args)
    service.call
  end
end
