require 'rubygems'
require 'curb'
require 'curb-fu'
require 'json'

realTextUrl = "http://soundcloud.com/kaskade/kaskades-bbc-radio-1-essential"
def playUrl(baseUrl)
	clientId = "35512355c477e90845d75bf1d77608a4"
	resolve = CurbFu.get('http://api.soundcloud.com/resolve.json?client_id=' + clientId + '&url=' + baseUrl)
	trackUrl = resolve.headers['Location']
	trackResponse = CurbFu.get(trackUrl)
	trackdata = JSON.parse(trackResponse.body)
	streamUrl = trackdata['stream_url'] + '?client_id=' + clientId
	system("mplayer " + '"' + streamUrl + '" -volume 30')
end
