#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'slop'
require 'nice'

opts = Slop.parse(help: true) do
  banner "Usage: #{$0} HOST [OPTIONS]"

  on 'port=', 'Port to connect to',               default: '6667'
  on 'nick=', 'Nick (and username) to use',       default: 'examplenick'
  on 'log=',  'Filename to log to (default: irc.log, stderr if blank)', default: 'irc.log'
end

if ARGV.length != 1
  puts opts
  exit 1
end

host = ARGV.fetch(0)

if opts[:log] != ''
  $stderr.reopen File.open(opts[:log], 'a')
  $stderr.sync = true
end

begin
  Nice.run!(host, opts[:port], opts[:nick])
rescue
  if $stderr.is_a?(File)
    puts "Something went wrong. Check #{$stderr.path}, or run again with --log '' to output to stderr."
  end

  raise
end

