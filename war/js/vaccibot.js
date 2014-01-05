/**
 * 
 */
var userId


function makeRequest(url,async) {
	var httpRequest;
	if (window.XMLHttpRequest) {
		// Mozilla, Safari, ...
		httpRequest = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		// IE
		try {
			httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (e) {
			try {
				httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (e) {}
		}
	}

	if (!httpRequest) {
		//alert('Giving up :( Cannot create an XMLHTTP instance');
		return false;
	}
	httpRequest.open('POST', url,async);	
	httpRequest.send();
	return httpRequest;
}

setName=function(f){
	window.name = "This message will survive between page loads.";

};


//function loginUser(){

//
// userid = document.getElementById("userName").value ; 
//Session.set("name", userid);
//document.getElementById("vaccibotBox").style.display = "block";
//}


function addText() {

	var username = sessvars.username;
	var msg = document.getElementById("comments").value;



	op = document.createElement('p');

	op.innerHTML ="<b>"+username+"</b>:  "+ msg;
	ocontent = document.getElementById('vaccibotBox');
	ocontent.appendChild(op);


	var sendMessageURI = '/askVaccibot?message='+msg ;

	var httpRequest = makeRequest(sendMessageURI,true);
	httpRequest.onreadystatechange = function(){
		if (httpRequest.readyState === 4) {
			if (httpRequest.status === 200) {

				op = document.createElement('p');

				op.innerHTML ="<b>Vaccibot</b>:  "+ httpRequest.responseText+"<br />"
				ocontent.appendChild(op);
			}else {

			}
		}
	}
}





