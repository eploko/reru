require 'reru/runner'

class Reru::BinaryRunner < Reru::Runner
  def run(target, arg)
    raise ArgumentError, 'The target is nil!' unless target
    if @method
      target.send(@method, arg)
    else
      @block.call(target, arg)
    end
  end
end
