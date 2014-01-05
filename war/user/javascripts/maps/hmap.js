 var map;
  var geocoder;
  var centerChangedLast;
  var reverseGeocodedLast;
  var currentReverseGeocodeResponse;
  var marker;
  var infowindow = new google.maps.InfoWindow();
  var latFromDB = <%=xLat%>;
  var lonFromDB = <%=yLon%>;
  
  function initialize() {
  	if(latFromDB.length<1||lonFromDB.length<1){
    	var latlng = new google.maps.LatLng(24.1089,77.41784);
  	}
    else{
    	var latlng = new google.maps.LatLng(latFromDB,lonFromDB);
    }
    	
    var myOptions = {
      zoom: 4,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    
  	if(latFromDB.length>1 && lonFromDB.length>1)
    	marker= new google.maps.Marker({position:latlng,map:map});
  		
	google.maps.event.addListener(map, 'click', function(event) {
	document.getElementById("xCor").value=event.latLng.lat();
	document.getElementById("yCor").value=event.latLng.lng();
  placeMarker(event.latLng);
   });
    geocoder = new google.maps.Geocoder();

  }




  function geocode() {
  
    var address = document.getElementById("address").value;
    geocoder.geocode({
      'address': address,
      'partialmatch': true}, geocodeResult);
  }

  function geocodeResult(results, status) {
    if (status == 'OK' && results.length > 0) {
      map.fitBounds(results[0].geometry.viewport);
    } else {
      alert("Please enter a location to search your vaccination center on the map.\ne.g. New Delhi, Shahdara etc.");
    }
  }

  

function placeMarker(location) {

  if ( marker ) {
  geocoder.geocode({'latLng': location}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      if (results[1]) {
        
         marker.setPosition(location);
        infowindow.setContent(results[1].formatted_address);
        infowindow.open(map, marker);
        document.getElementById("addressLine1").value=results[1].formatted_address;
      } else {
        alert('No results found');
      }
    } else {
      alert('Geocoder failed due to: ' + status);
    }
  });

   
  } else {

  geocoder.geocode({'latLng': location}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      if (results[1]) {
        
        marker = new google.maps.Marker({
            position: location,
            map: map
        });
        infowindow.setContent(results[1].formatted_address);
        document.getElementById("addressLine1").value=results[1].formatted_address;
        infowindow.open(map, marker);
      } else {
        alert('No results found');
      }
    } else {
      alert('Geocoder failed due to: ' + status);
    }
  });

    
  }
}
