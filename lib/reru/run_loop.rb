class Reru::RunLoop
  
  attr_reader :emitters
  
  def initialize
    @emitters = []
  end
  
  def run
    while @emitters.size > 0
      ticking_emitters = @emitters
      @emitters = []
      ticking_emitters.each do |e|
        a = e.tick
        validate_answer(a)
        add_emitter(emitter, false) if a == Reru.more
      end
    end
  end
  
  def add_emitter(emitter, should_validate = true)
    validate_emitter(emitter) if should_validate
    @emitters << emitter
  end
  
private

  def validate_answer(answer)
    raise TypeError, "A Reru::More expected. Got: #{answer.class}" unless answer.is_a?(Reru::More)
  end

  def validate_emitter(emitter)
    raise ArgumentError, "A Reru::Emitter expected. Got: #{emitter.class}" unless emitter.is_a?(Reru::Emitter)
  end

end

module Reru::RunLoop::ReruExt
  def run
    run_loop.run
  end

  def run_loop
    @run_loop ||= Reru::RunLoop.new
  end

  def run_loop=(rl)
    @run_loop = rl
  end
end

Reru.send :extend, Reru::RunLoop::ReruExt

