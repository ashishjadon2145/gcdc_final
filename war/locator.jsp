<%@ page import="java.util.List" %>
<%@ page import= "java.util.Iterator" %>
<%@ page import= "com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter" %>
<!doctype html>
<html  lang="en">
  <head>
  
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Foundation | Welcome</title>
    <link rel="stylesheet" href="css/foundation5/foundation.css" />
    
    <style>
    	#map_canvas{
    		width:100%;
    		height:425px;
    	}
    </style>
    <script src="js/foundation5/modernizr.js"></script>
	<script>
		function CaptchaNumber(evt){

                               var charCode = (evt.which) ? evt.which : event.keyCode;
                               if (charCode > 31  && (charCode < 48 || charCode > 57  )  )
                                       return false;
                               return true;
                       }
		
		function pinCheck(){
			var data = $('#fetchpin').val();
			if(data == "" || data.length != 6)
			{	
				alert('Pincode should be 6 numeric characters only.')
				return false;
			}
			document.getElementById('form4343').submit();
			return true;
			
		}
		</script>    
     <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
    
    <script>

var test = [];
var marker;
var markers = [];


function initialize()
{
	//alert("test:    "+test.length);
	if(test.length == 0)
		{
		var myLatLng = new google.maps.LatLng(24.1089,77.41784);
        var map_canvas = document.getElementById('map_canvas');
        var map_options = {
          center: myLatLng,
          zoom: 4,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        var map = new google.maps.Map(map_canvas, map_options)
		}
	else{
var foo = new google.maps.LatLng(28.535002, 77.105508)
var mapProp = { 
  center: foo ,
  zoom:8,
  mapTypeId:google.maps.MapTypeId.ROADMAP
  };
var map=new google.maps.Map(document.getElementById("map_canvas"),mapProp);


var infowindow = new google.maps.InfoWindow();

var contentString ;

var  i, destination ;

for (i = 0; i < test.length; i++) {  
    marker = new google.maps.Marker({
      position: new google.maps.LatLng(test[i][1], test[i][2]),
      map: map
    });

    
    contentString = '<div id="content123" style="color: black; ">'+

    '<h7>'+test[i][0]+'</h7>'+

    '<p>'+test[i][5]+' </br> '+test[i][3]+'  </br> '+test[i][4]+' </br> <a href="#" onClick="navigate(\'' + test[i][5] + '\')" />get direction</a>  </p>'+
    '</div>';
    google.maps.event.addListener(marker, 'click', (function(marker, i) {
      return function() {
        infowindow.setContent(contentString);
        infowindow.open(map, marker);
      }
    })(marker, i));
    markers.push(marker);
  }
		}
		}
function GetIndex(sender)
{   
	alert("in getindex");
    var aElements = sender.parentNode.parentNode.getElementsByTagName("a");
    var aElementsLength = aElements.length;

    var index;
    for (var i = 0; i < aElementsLength; i++)
    {
        if (aElements[i] == sender) //this condition is never true
        {
            index = i;
            alert(index);
            alert(marker)
            google.maps.event.trigger(markers[index], 'click');
        }
        
    }
}
function navigate(destination){
	if (navigator.geolocation) { //Checks if browser supports geolocation
		   navigator.geolocation.getCurrentPosition(function (position) {                                                              //This gets the
		     var latitude = position.coords.latitude;                    //users current
		     var longitude = position.coords.longitude;                 //location
		     var coords = new google.maps.LatLng(latitude, longitude); //Creates variable for map coordinates
		     var directionsService = new google.maps.DirectionsService();
		     var directionsDisplay = new google.maps.DirectionsRenderer();
		     var mapOptions = //Sets map options
		     {
		       zoom: 15,  //Sets zoom level (0-21)
		       center: coords, //zoom in on users location
		       mapTypeControl: true, //allows you to select map type eg. map or satellite
		       navigationControlOptions:
		       {
		         style: google.maps.NavigationControlStyle.SMALL //sets map controls size eg. zoom
		       },
		       mapTypeId: google.maps.MapTypeId.ROADMAP //sets type of map Options:ROADMAP, SATELLITE, HYBRID, TERRIAN
		     };
		     map = new google.maps.Map( /*creates Map variable*/ document.getElementById("map_canvas"), mapOptions /*Creates a new map using the passed optional parameters in the mapOptions parameter.*/);
		     directionsDisplay.setMap(map);
		     
		     var request = {
		       origin: coords,
		       destination: destination,
		       travelMode: google.maps.DirectionsTravelMode.DRIVING
		     };

		     directionsService.route(request, function (response, status) {
		       if (status == google.maps.DirectionsStatus.OK) {
		         directionsDisplay.setDirections(response);
		       }
		     });
		   });
		 }   
}

</script>
    
  </head>
  <body  onload="initialize()">
  

  <div class="fixed">
  <nav class="top-bar" data-topbar>
  <ul class="title-area">
    <li class="name">
      <h1><a href="index.html">Vaccinate</a></h1>
    </li>
    
  </ul>

  <section class="top-bar-section">
    <!-- Right Nav Section -->
    <ul class="right">
      <li class="active"><a href="#">Hello</a></li>
      <li><a href="#aboutus">Who are we?</a></li>
      
      <li class="has-dropdown">
        <a href="#">Vaccinate</a>
        <ul class="dropdown">
          <li><a href="scheduler.jsp">Scheduler</a></li>
          <li class="active"><a href="#">Locator</a></li>
          <li><a href="consult.html">Consultation</a></li>
          
        </ul>
      </li>
    </ul>

    <!-- Left Nav Section -->
    
  </section>
</nav>
</div>


	<div class="row">
		<div class="large-12 columns">
		
			<h2> Find the nearest Vaccination center in your locality</h2>
		
		</div>
	
	</div>

  <div class="row">    
    
    <!-- Main Content Section -->
    <!-- This has been source ordered to come first in the markup (and on small devices) but to be to the right of the nav on larger screens -->
    <div class="large-8 push-4 columns">
      
     <h3>Map<small> Get the directions</small> <!-- <a href="#" class="button right small">View All</a>--></h3>
      
      <div id="map_canvas"></div>
                  
    </div>
    
    <br />
    <!-- Nav Sidebar -->
    <!-- This is source ordered to be pulled to the left on larger screens -->
    
    <div class="large-4 pull-8 columns">
        Enter your pincode here
      <ul class="side-nav">
      
      <form id="form4343" action="fetchLocation" method="post" onsubmit="pinCheck();">
        <li>
        	<input type="hidden" id="action" name="action" value="fetchLocationByPincode" />
        	<input type="text" maxlength="6" onkeypress='return CaptchaNumber(event)' name="fetchpin" id="fetchpin" placeholder="Pin code">
        </li>
		<input class="button small" type="submit" value="Search">
      </form>
      
      <form id="form4344" action="fetchLocation" method="post" onsubmit="">
        
        	<input type="hidden" id="action" name="action" value="fetchLocationByState" />
      
      	<select name="Points" size="1" id="Points">
			<option value="Andhra Pradesh">Andhra Pradesh</option>
			<option value="Arunachal Pradesh">Arunachal Pradesh</option>
			<option value="Assam">Assam</option>
			<option value="Bihar">Bihar</option>
			<option value="Chhattisgarh">Chhattisgarh</option>
			<option value="Goa">Goa</option>
			<option value="Gujarat">Gujarat</option>
			<option value="Haryana">Haryana</option>
			<option value="Himachal Pradesh">Himachal Pradesh</option>
			<option value="Jammu and Kashmir">Jammu and Kashmir</option>
			<option value="Jharkhand">Jharkhand</option>
			<option value="Karnataka">Karnataka</option>
			<option value="Kerala">Kerala</option>
			<option value="Madhya Pradesh">Madhya Pradesh</option>
			<option value="Maharashtra">Maharashtra</option>
			<option value="Manipur">Manipur</option>
			<option value="Meghalaya">Meghalaya</option>
			<option value="Mizoram">Mizoram</option>
			<option value="Nagaland">Nagaland</option>
			<option value="Odisha">Odisha</option>
			<option value="Punjab">Punjab</option>
			<option value="Rajasthan">Rajasthan</option>
			<option value="Sikkim">Sikkim</option>
			<option value="Tamil Nadu">Tamil Nadu</option>
			<option value="Tripura">Tripura</option>
			<option value="Uttar Pradesh">Uttar Pradesh</option>    
			<option value="Uttarakhand">Uttarakhand</option>
			<option value="West Bengal">West Bengal</option>
		</select>
		
		<input class="button small" type="submit" value="Search">
		
		</form>
        <hr />
        <%
			List list = (List)request.getAttribute( "resultList" ); 
			if(list!=null){

		        out.print("<li id=\"numResults\" class=\"right\"> <strong>"+list.size()+"</strong> Results found</li>");
		        out.print("<div class=\"results\" >");
		        		out.print("<table style=\"width:100%\">");
			
				 Iterator<Object[]> i = list.iterator();
				 System.out.println("iterator = "+i);
				 int k = 0;
				 while (i.hasNext())
				
					{
					    Object[] pd = i.next();	
						int pin_db = (Integer) pd[0];
						String name = (String)pd[1];
						String centername = (String)pd[1];
						String xcor = (String)pd[2];
						String ycor = (String)pd[3];
						String contact1 = (String)pd[4];
						String add1 = (String)pd[5];
						out.print("<tr>");
								out.print("<td><a href=\"#\" onclick=\"GetIndex(this)\">"+name+"</a></td>");
						out.print("</tr>");
						%>
						  <script language=javascript>  
						test.push(["<%= centername %>", <%= xcor %> , <%= ycor %> ,"<%= pin_db %>","<%= contact1 %>","<%= add1 %>" ]);
						</script>  
						<%
						k++;
					}
					
					 out.print("</table>");
				 out.print("</div>");
			} 
 %>
        
      </ul>
      
        
    </div>
    
  </div>
    
  
  <!-- Footer -->
  
  <footer class="row">
    <div class="large-12 columns">
      <hr />
      <div class="row">
        <div class="large-6 columns">
          <p>© Copyright no one at all. Go to town.</p>
        </div>
        <div class="large-6 columns">
          <ul class="inline-list right">
            <li><a href="index.html#aboutus">About Vaccinate</a></li>
            <li><a href="index.html#feedback">Feedback</a></li>
            <li><a href="faqs.html">FAQs</a></li>
            <li><a href="volunteer.html">Volunteer</a></li>
          </ul>
        </div>
      </div>
    </div> 
  </footer>




   
    
        
    <script src="js/foundation5/jquery.js"></script>
    <script src="js/foundation5/foundation.min.js"></script>
    <script src="js/foundation5/foundation.topbar.js"></script>
    <!-- <script src="js/foundation.orbit.js"></script> -->
    <!-- <script src="js/foundation/foundation.abide.js"></script>-->
    <script>
      $(document).foundation();
    </script>
  </body>
</html>
