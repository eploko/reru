#!/usr/bin/env ruby

require 'reru'

once = Reru.once(5)
once.log
once.flush
