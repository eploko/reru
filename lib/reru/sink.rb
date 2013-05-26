require 'reru/event/validations'
require 'reru/more'
require 'reru/receiver/validations'
require 'reru/sink/operations'

module Reru::Sink
  include Reru::Sink::Operations
  
  attr_accessor :run_loop
  
  def add_receiver(receiver)
    validate_receiver(receiver)
    receivers << receiver
  end
  
  def remove_receiver(receiver)
    validate_receiver(receiver)
    receivers.delete(receiver)
  end

  def sink(event)
    validate_event(event)
    perform_eos_handlers if event.eos?
    receivers.each do |r|
      a = r.receive(self, event)
      validate_answer(r, a)
      a
    end
  end

  def merge(right)
    Reru::Stream.new(self, right)
  end
  
  def on_eos(&block)
    eos_handlers << block
  end
  
private

  include Reru::Receiver::Validations
  include Reru::Event::Validations
    
  def receivers
    @receivers ||= []
  end
  
  def eos_handlers
    @eos_handlers ||= []
  end
  
  def perform_eos_handlers
    eos_handlers.each { |b| b.call }
  end
  
  def validate_answer(receiver, a)
    unless a.is_a?(Reru::More)
      raise TypeError, "#{receiver.class} returned and invalid answer of class: #{a.class}. A Reru::More expected."
    end
  end
  
end
