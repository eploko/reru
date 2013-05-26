#!/usr/bin/env ruby

unless ARGV.length >= 1
  $stderr.puts "Usage: #{$0} HOST [PORT]"
  exit 1
end

require 'reru'
require 'socket'

socket = TCPSocket.new(ARGV[0], ARGV[1] || 23)

Reru.read(socket).write($stdout)
Reru.read($stdin).write(socket)
Reru.run
