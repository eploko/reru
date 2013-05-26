#!/usr/bin/env ruby
# encoding: utf-8

require 'reru'

Reru::IO::Reader.new($stdin).map { |line| "Haha! You said “#{line.chomp}”.\n" }.write($stdout)
Reru.run
