#!/usr/bin/env ruby

require 'reru'

#
# Converting strings to integers, skipping empty values.
#

strings = ['10', '', '45', '', '', '1'].as_emitter
strings.flat_map{ |str| 
  unless str.empty?
    str.to_i
  else
    Reru::never
  end
}.log
strings.start
