class Reru::FuncRunner
  def initialize(method = nil, &block)
    @method = method
    @block = block
  end
  
  def run(target, arg)
    if @method
      target.send(@method, arg)
    else
      @block.call(target, arg)
    end
  end
end
