require 'reru/runner'

class Reru::UnaryRunner < Reru::Runner  
  def run(target)
    raise ArgumentError, 'The target is nil!' unless target
    if @method
      target.send(@method)
    else
      @block.call(target)
    end
  end
end
