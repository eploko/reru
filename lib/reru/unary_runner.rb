require 'reru/runner'

class Reru::UnaryRunner < Reru::Runner  
  def run(target)
    if @method
      target.send(@method)
    else
      @block.call(target)
    end
  end
end
