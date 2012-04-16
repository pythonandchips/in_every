require 'in_every/enumerator_extensions'

class InEvery
  class SetupException < Exception; end

  def initialize enum, executions
    @executions = (executions - 1)
    @enum = enum
    generate_occurances
  end

  def generate_occurances
    raise SetupException.new("occurancies must be greater than executions") if @enum.max > @executions
    @failures = (0..(@executions)).to_a.sample(@enum.max).sort
  end

  def start(&block)
    @method = block
  end

  def execute *args
    @counter ||= 0
    if @counter == @failures.first
      @method.call(*args)
      @failures.delete_at(0)
    end
    if @counter == @executions
      @counter = nil
      generate_occurances
    else
      @counter += 1
    end
  end
end
