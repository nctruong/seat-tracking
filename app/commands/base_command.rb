class BaseCommand
  attr_reader :errors

  def initialize(*_params)
    @errors = []
  end

  def self.execute(*args)
    command = new(*args)
    command.call
  end
end
