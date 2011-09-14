var ws = new WebSocket("ws://10.11.21.1:2011");
ws.onopen = function(){
	ws.send("Hello Server!");
}
ws.onmessage = function(evt){
	message = evt.data;
	if(message == "Hello Client!"){
		console.log("!!Handshake recived");
	}
	else{
		console.log(message);
	}
}
function ClickHandler(info, tab){
	var url = info.linkUrl;
	console.log(url);
	ws.send(url);
}


chrome.contextMenus.create({'title': "RemotePlay", 'contexts': ["link"], 'onclick': ClickHandler});
