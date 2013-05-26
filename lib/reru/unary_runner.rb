require 'reru/runner'

class Reru::UnaryRunner < Reru::Runner  
  def run(target)
    if @method
      raise ArgumentError, 'The target is nil!' unless target
      target.send(@method)
    else
      @block.call(target)
    end
  end
end
