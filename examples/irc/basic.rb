#!/usr/bin/env ruby

unless ARGV.length >= 1
  $stderr.puts "Usage: #{$0} HOST [PORT [NICK]]"
  exit 1
end

$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'reru'
require 'irc_event'
require 'socket'
require 'colored'

def main
  host = ARGV.fetch(0)
  port = ARGV.fetch(1) { "6667"     }
  nick = ARGV.fetch(2) { "examplenick" }

  socket = TCPSocket.new(host, port)

  network_in = Reru.read(socket)
  user_in = Reru.read
  
  server_events = network_in.map { |line| IRCEvent.parse(line) }

  client          = Client.new(nick)
  client_commands = client.transform(server_events)
  network_out     = user_in.merge(client_commands)

  ui       = UI.new
  user_out = ui.transform(client_commands, server_events)

  network_out.map{|l| "#{l}\n" }.write(socket)
  user_out.map{|l| "#{l}\n" }.write
    
  Reru.run
end

class Client < Struct.new(:nick)
  def transform(server_events)
    nick_and_user = [
      "NICK #{nick}",
      "USER #{nick} () * #{nick}"
    ].as_emitter

    ping = server_events.select { |msg| msg.command == "PING" }
    pong = ping.map { |msg| "PONG " + msg.params.join(" ") }

    nick_and_user.merge(pong)
  end
end
 
class UI
  def transform(client_commands, server_events)
    incoming_messages = server_events.select { |event| event.command == "PRIVMSG" }
    other_events      = server_events.select { |event| event.command != "PRIVMSG" }

    message_lines = incoming_messages.map { |event|
      channel = event.params[0]
      user    = "<#{event.user}>"
      message = event.params[1]

      "#{channel.green} #{user.yellow} #{message}"
    }

    message_lines
      .merge(other_events.map { |event| "< #{event.line}".magenta })
      .merge(client_commands.map { |line| "> #{line}".magenta })
  end
end

main
