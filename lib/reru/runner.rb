class Reru::Runner
  def initialize(method = nil, &block)
    raise ArgumentError, 'No method name or block given' unless method || block
    raise ArgumentError, 'Either give a method name _or_ a block, not both' if method && block
    @method = method
    @block = block
  end
end
