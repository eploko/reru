#!/usr/bin/env ruby

require 'reru'

nums = [1, 2, 3].as_emitter
counter = nums.scan(0, :+).scan(1){ |a, b| a*b }
counter.log
nums.start
