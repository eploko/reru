class Reru::Runner
  def initialize(method = nil, &block)
    @method = method
    @block = block
  end
end
