#!/usr/bin/env ruby

require 'reru'

Reru.read.scan({total: 0}) do |s, line|
  if line.strip.empty?
    {total: 0, message: "Total: #{s[:total]}"}
  else
    {total: s[:total] + line.to_f}
  end
end.select{ |s| s.has_key?(:message) }.map{ |s| s[:message] + "\n\n" }.write

Reru.run
