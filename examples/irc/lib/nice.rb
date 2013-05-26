require 'reru'
require 'socket'

require 'nice/client'
require 'nice/ui'
require 'nice/manager'

module Nice
  def self.run!(host, port, nick)
    client  = Client.new(nick)
    ui      = UI.new(nick)
    manager = Manager.new(client, ui)

    socket = TCPSocket.new(host, port)

    network_in = Reru.read(socket)
    user_in = Reru.read
    network_out, user_out = manager.transform(network_in, user_in)
    network_out.write(socket)
    user_out.write
  end
end
