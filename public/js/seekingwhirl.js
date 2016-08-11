var HttpClient = function() {
	this.get = function(aUrl, aCallback) {
		var anHttpRequest = new XMLHttpRequest();
		anHttpRequest.onreadystatechange = function() { 
		if (anHttpRequest.readyState == 4 && anHttpRequest.status == 200)
			aCallback(anHttpRequest.responseText);
		}
		anHttpRequest.open( "GET", aUrl, true );            
		anHttpRequest.send( null );
	}
}

aClient = new HttpClient();
aClient.get('https://api.github.com/repos/Azbuka-slovensko/SeekingWhirl/tags', function(response) {
	var latest = JSON.parse(response)[0]["name"].replace('v','');
	var selectors = document.querySelectorAll(".sw-version");
	for (var i = 0; i < selectors.length; ++i) {
		selectors.item(i).innerHTML = latest;
	}
});