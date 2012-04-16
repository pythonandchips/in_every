class Enumerator #nodoc

  #extension to create InEvery based on the enumeration
  #
  #==Parameters
  #int::
  #  number of calls in a cycle
  #
  #block::
  #  what to execute randomly in cycle
  def in_every int, &block
    InEvery.new(self, int, block)
  end
end
