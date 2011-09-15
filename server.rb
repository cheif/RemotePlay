require 'rubygems'
require 'em-websocket'
require 'mediaplayer'

puts "Starting server"

soundcloudURL = Regexp.new(/soundcloud.com*/);
youtubeURL = Regexp.new(/youtube.com\/watch\?*/);

player = Mediaplayer.new

EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 2011) do |ws|
	ws.onopen { 
		ws.send "Hello Client!"
	}
	ws.onmessage {|msg|
		if msg == "Hello Server!"
			puts "!!Handshake recived"
		else
			case
			when soundcloudURL.match(msg) then player.soundcloud(msg)
			when youtubeURL.match(msg) then player.youtube(msg)
			else 
				puts "#{msg} is not a valid url"
			end
		end
	}
	ws.onclose {}
end
