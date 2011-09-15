require 'rubygems'
require 'curb'
require 'curb-fu'
require 'json'

class Mediaplayer
	def soundcloud(baseUrl)
		puts "Playing soundcloud resource"
		clientId = "35512355c477e90845d75bf1d77608a4"
		resolve = CurbFu.get('http://api.soundcloud.com/resolve.json?client_id=' + clientId + '&url=' + baseUrl)
		trackUrl = resolve.headers['Location']
		trackResponse = CurbFu.get(trackUrl)
		trackdata = JSON.parse(trackResponse.body)
		streamUrl = trackdata['stream_url'] + '?client_id=' + clientId
		system("mplayer " + '"' + streamUrl + '" -volume 30')
	end

	def youtube(baseUrl)
		puts "Playing youtube resource"
		# Using external program youtube-dl to resolve link
		url = `./youtube-dl --cookies cookies.txt -g "#{baseUrl}"`
		print url;
		system('mplayer -cookies -cookies-file cookies.txt "http://o-o.preferred.arn06s03.v18.lscache2.c.youtube.com/videoplayback?sparams=id%2Cexpire%2Cip%2Cipbits%2Citag%2Cratebypass%2Coc%3AU0hQS1BQU19FSkNOMF9ISldH&fexp=912305%2C915600&itag=45&ip=0.0.0.0&signature=19194B23592639E325BBE9912334325FC2C22DBB.5EA71FDDD47080B5F30A9BA758E589591AE7522A&sver=3&ratebypass=yes&expire=1316055600&key=yt1&ipbits=0&id=2da219d26509cebd" -vo none -volume 30')
	end

end
