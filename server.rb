require 'rubygems'
require 'em-websocket'
require 'player'

puts "Starting server"

validUrls = Regexp.new(/http:\/\/soundcloud.com*/);

EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 2011) do |ws|
	ws.onopen { 
		ws.send "Hello Client!"
	}
	ws.onmessage {|msg|
		if msg == "Hello Server!"
			puts "!!Handshake recived"
		elsif validUrls.match(msg)
			puts "Valid URL"
			playUrl(msg)
		else 
			puts "#{msg} is not a valid url"
		end
	}
	ws.onclose {}
end
