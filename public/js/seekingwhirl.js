var HttpClient=function(){this.get=function(e,t){var n=new XMLHttpRequest;n.onreadystatechange=function(){4==n.readyState&&200==n.status&&t(n.responseText)},n.open("GET",e,!0),n.send(null)}};aClient=new HttpClient,aClient.get("https://api.github.com/repositories/48803553/tags",function(e){for(var t=JSON.parse(e)[0].name.replace("v",""),n=document.querySelectorAll(".sw-version"),a=0;a<n.length;++a)n.item(a).innerHTML=t});