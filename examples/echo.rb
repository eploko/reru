#!/usr/bin/env ruby
# encoding: utf-8

$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'reru'

reader = Reru::IO::Reader.new($stdin)
reader.map { |line| 
  "> Haha! You said “#{line.chomp}”.\n" 
}.write($stdout)
reader.select { |line| line.chomp == 'quit' }.perform { reader.stop }

Reru::run
