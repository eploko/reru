#!/usr/bin/env ruby
# encoding: utf-8

$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'reru'

Reru::IO::Reader.new($stdin).map { |line| 
  "Haha! You said “#{line.chomp}”." 
}.write($stdout)

Reru::run
