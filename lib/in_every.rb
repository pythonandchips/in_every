require 'in_every/enumerator_extensions'

#Randomly execute a block of code x number of times in every number of runs
#Example:
#  in_every = 5.times.in_every(20) do
#    ##some really cool code
#  end
#
#  #will return value of the block if executed or nil if nothing happened
#  in_every.execute
class InEvery
  #thrown if there is a problem setting up InEvery
  class SetupException < Exception; end

  #create new in every instance
  #
  #==Parameters:
  #enum::
  # enumeration number for cycling through executions
  #
  #executions::
  #  number or times the proc is to be randomly executed
  #
  #method::
  #  What to execute randomly in a cycle
  #
  #==Returns:
  #  new instance of InEvery
  def initialize(enum, executions, method)
    @executions = (executions - 1)
    @enum = enum
    @method = method
    generate_occurances
    raise SetupException.new("occurancies must be greater than executions") if @enum.max > @executions
  end

  #execute the given proc if randomly
  #
  #==Parameters:
  #args::
  #  arguments required to execute the proc
  #
  #==Returns:
  #the result of the block or nil if nothing was executed
  def execute *args
    @counter ||= 0
    if @counter == @execution_points.first
      result = @method.call(*args)
      @execution_points.delete_at(0)
    end
    if @counter == @executions
      @counter = nil
      generate_occurances
    else
      @counter += 1
    end
    result
  end

  private

  def generate_occurances #nodoc
    @execution_points = (0..(@executions)).to_a.sample(@enum.max).sort
  end
end
