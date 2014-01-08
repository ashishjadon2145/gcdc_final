<!doctype html>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%!
	String parentLoginUrl ;
	String hospitalLoginUrl ;
	String freelancerLoginUrl ;
	String volunteerLoginUrl ;
%>
<%
	parentLoginUrl = UserServiceFactory.getUserService().createLoginURL("/login?role=1");
	hospitalLoginUrl = UserServiceFactory.getUserService().createLoginURL("/login?role=2");
	freelancerLoginUrl = UserServiceFactory.getUserService().createLoginURL("/login?role=5");
	volunteerLoginUrl = UserServiceFactory.getUserService().createLoginURL("/login?role=6");
%>

<html lang="en">
<head>

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Foundation | Welcome</title>
<link rel="stylesheet" href="css/foundation.css" />

<style>
#map_canvas {
	width: 100%;
	height: 425px;
}

li.even1 {
	background-color: #fafafa;
	padding-top: 4px;
	padding-bottom: 4px;
}
</style>
<script src="js/modernizr.js"></script>
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
var gmarkers = [];
var side_bar_html = "";
var navMap ;

function initializeNavigate(){
	var myLatLng = new google.maps.LatLng(24.1089,77.41784);
    var map_can = document.getElementById('navMap');
    var map_options = {
      center: myLatLng,
      zoom: 12,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    navMap = new google.maps.Map(map_can, map_options);
}
	
google.maps.event.addDomListener(window, 'load', initializeNavigate);
google.maps.event.addDomListener(window, 'load', initialize);



function initialize()
{
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
else
{
var foo = new google.maps.LatLng(28.535002, 77.105508);
var bounds = new google.maps.LatLngBounds();

var mapProp = { 
  center: foo ,
  zoom:8,
  mapTypeId:google.maps.MapTypeId.ROADMAP
  };
var map=new google.maps.Map(document.getElementById("map_canvas"),mapProp);


var infowindow = new google.maps.InfoWindow();



var  i;

for (i = 0; i < test.length; i++) {  


var lat = test[i][1];
    var lng = test[i][2]; 
    var point = new google.maps.LatLng(lat,lng);
   
var label = test[i][0];;





var marker = new google.maps.Marker({
        position: point,
        map: map
        });
bounds.extend(point);
    google.maps.event.addListener(marker, 'click', (function(marker, i) {
      return function() {
        infowindow.setContent('<div id="content123" style="color: black; ">'+
    '<h7>'+test[i][0]+'</h7>'+
    '<p>'+test[i][5]+' </br> '+test[i][3]+
    '</br> '+test[i][4]+' </br> <a href="#" onClick="navigate(\'' + test[i][1] + ',' + test[i][2] + '\')" />Get direction</a>  </p>'+
'</div>');
        infowindow.open(map, marker);
      }
    })(marker, i));
    
    gmarkers.push(marker);
    
      if( (gmarkers.length-1)%2 == 0)
    side_bar_html += '<li class="odd1"><a href="javascript:myclick(' + (gmarkers.length-1) + ')">' + test[i][0] + '<\/a><\/li>';
    else
    	side_bar_html += '<li class="even1"><a href="javascript:myclick(' + (gmarkers.length-1) + ')">' + test[i][0] + '<\/a><\/li>';
  }

map.fitBounds(bounds); 
}
document.getElementById("side_bar").innerHTML = side_bar_html;
}
function myclick(i) {

  google.maps.event.trigger(gmarkers[i], "click");
}

var dirMap;
var user_coords;

function navigate(destination ){
 
  initializeNavigate();
  var s = destination.toString();
  var fields = s.split(/,/);
  var xValue = fields[0];
  var yValue = fields[1];
  var destinationCoords = new google.maps.LatLng(xValue, yValue);
  
if (navigator.geolocation) { //Checks if browser supports geolocation
   navigator.geolocation.getCurrentPosition(function (position) {                                                              //This gets the
     var latitude = position.coords.latitude;                    //users current
     var longitude = position.coords.longitude;                 //location
     var coords = new google.maps.LatLng(latitude, longitude); //Creates variable for map coordinates
     user_coors = coords;
     var directionsService = new google.maps.DirectionsService();
     var directionsDisplay = new google.maps.DirectionsRenderer();
     var mapOptions = //Sets map options
     {
       zoom: 12,  //Sets zoom level (0-21)
       center: coords, //zoom in on users location
       mapTypeControl: true, //allows you to select map type eg. map or satellite
       navigationControlOptions:
       {
         style: google.maps.NavigationControlStyle.SMALL //sets map controls size eg. zoom
       },
       mapTypeId: google.maps.MapTypeId.ROADMAP //sets type of map Options:ROADMAP, SATELLITE, HYBRID, TERRIAN
     };
     dirMap = new google.maps.Map( /*creates Map variable*/ document.getElementById("navMap"), mapOptions /*Creates a new map using the passed optional parameters in the mapOptions parameter.*/);
     directionsDisplay.setMap(dirMap);
   
     var request = {
       origin: coords,
       destination: destinationCoords,
       travelMode: google.maps.DirectionsTravelMode.DRIVING
     };

     directionsService.route(request, function (response, status) {
       if (status == google.maps.DirectionsStatus.OK) {
    	   
         directionsDisplay.setDirections(response);
         console.log(response);
         $('#mapModal').foundation('reveal','open');
         google.maps.event.trigger(navMap, "resize");
         
       }
     });
   });
   
   
}   
else
alert("your browser can't find your location.");
}
</script>
 <script src="js/vaccibot.js"></script>
		<script src="js/sessvar.js"></script>
		<script type="text/javascript" >
			function setName(){
				//alert("1");
				var data = document.getElementById("userName").value;
				if(data == null || data =="")
				{	
					//show error on the name field and donot show the next modal
					//write the error here.
					return false;
				}
				sessvars.username = data;
			}
		</script>


</head>
<body onload="initialize()">



	<div class="fixed">
  <nav class="top-bar" data-topbar>
  <ul class="title-area">
    <li class="name">
      <h1><a href="/index.jsp">Vaccinate</a></h1>
    </li>
    <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
    
  </ul>

  <section class="top-bar-section">
    <!-- Right Nav Section -->
    <ul class="right">
      	<li class="active"><a href="index.jsp#aboutus">Home</a></li>
      	<li><a href="index.jsp#getInvolved">Get Involved</a></li>
      
		<li class="has-dropdown not-click"><a href="#">What all you can do</a>
        <ul class="dropdown">
			<!-- Parent tab start-->
			<li><label>Parent</label></li>
          		<!-- Scheduler tab start-->
	          	<li  class=""><a href="scheduler.jsp">Scheduler</a>

	          	</li>
          		<!-- Scheduler tab end-->
	          	<!-- Locator tab start-->
	          	<li  class=""><a href="locator.jsp">Locator</a>
		            
	          	</li>
	          	<!-- Locator tab end-->
	          	<!-- Reminders tab start-->
	          	<li  class=""><a href="<%=parentLoginUrl%>">Reminders</a>
		            
	            	
	          	</li>
	          	<!-- Reminders tab end-->
	          	<!-- Consultation tab start-->
	          	<li  class="has-dropdown not-click"><a href="">Consultation</a>
		            <!-- Nested Dropdown -->
	            	<ul class="dropdown">
	              		<li><a href="#" data-reveal-id="nameModal">24X7 Assistance by VacciBot</a></li>
	              		<%-- <li><a href="<%=parentLoginUrl%>">Discuss with other parents</a></li>
	              		<li><a href="<%=parentLoginUrl%>">Ask VacciExpert your queries everyday</a></li> --%>
	            	</ul>
	          	</li>
	          	<!-- Consultation tab end-->
			<!-- Parent tab end-->
			<!-- Hospital tab start-->
			
	        <!-- 
          	<li class="divider"></li>
          	<li><label>Hospitals - Doctor</label></li>
          		<li><a href="scheduler.jsp">Vaccinate at Home</a></li>
			-->
			<!-- Hospital tab end-->
        </ul>
      </li>
      
     
      
      <li class="has-dropdown">
      	<a href="#">Login As</a>
      	<ul class="dropdown">
      		<li> <a href="<%=parentLoginUrl%>">Parent</a></li>
      		<li> <a href="<%=hospitalLoginUrl%>">Hospital</a></li>
      		<li> <a href="<%=volunteerLoginUrl%>">Volunteer</a></li>    		
      	
      	</ul>
      </li>
    </ul>    <!-- Left Nav Section -->
    
  </section>
  </nav></div>


	<div class="row">
		<div class="large-12 columns">

			<h2>Find the nearest Vaccination center in your locality</h2>

		</div>

	</div>
	
	<div class="row">
	
	<div class="large-4  columns">
			<ul class="side-nav" style="margin-top:-15px;">
				<h3>Search</h3>
			

					<li>
					    <div class="row">
					    <form id="form4343" action="fetchLocation" method="post" onsubmit="return pinCheck();">
					    <div class="large-12 columns">
					    	<h6>In an Area</h6>
					    </div>
						<div class="large-8 columns">
						
							<input type="hidden" id="action" name="action"
								value="fetchLocationByPincode" /> <input type="text"
								maxlength="6" onkeypress='return CaptchaNumber(event)'
								name="fetchpin" id="fetchpin" placeholder="Pin code" />
						</div>
						<div class="large-4 columns">
							<input class="  button tiny" type="submit" value="Search" />
						</div>
						</form>
						</div>
					
					</li>




				
				<li>
				
				  <div class="row" style="margin-top:-20px;">
				  <form id="form4344" action="fetchLocation" method="post" onsubmit="">
					<div class="large-12 columns">
						<h6>In a State</h6>
					</div>
					<div class="large-8 columns">
					
					<input type="hidden" id="action" name="action"
						value="fetchLocationByState" /> <select name="Points" size="1"
						id="Points">
						<option value="1">Andaman and Nicobar Islands</option>
						<option value="2">Andhra Pradesh</option>
						<option value="3">Arunachal Pradesh</option>
						<option value="4">Assam</option>
						<option value="5">Bihar</option>
						<option value="6">Chandigarh</option>
						<option value="7">Chhattisgarh</option>
						<option value="8">Dadra and Nagar Haveli</option>
						<option value="9">Daman and Diu</option>
						<option value="10">Delhi</option>
						<option value="11">Goa</option>
						<option value="12">Gujarat</option>
						<option value="13">Haryana</option>
						<option value="14">Himachal Pradesh</option>
						<option value="15">Jammu and Kashmir</option>
						<option value="16">Jharkhand</option>
						<option value="17">Karnataka</option>
						<option value="18">Kerala</option>
						<option value="19">Lakshadweep</option>
						<option value="20">Madhya Pradesh</option>
						<option value="21">Maharashtra</option>
						<option value="22">Manipur</option>
						<option value="23">Meghalaya</option>
						<option value="24">Mizoram</option>
						<option value="25">Nagaland</option>
						<option value="26">Odisha</option>
						<option value="27">Puducherry</option>
						<option value="28">Punjab</option>
						<option value="29">Rajasthan</option>
						<option value="30">Sikkim</option>
						<option value="31 Nadu">Tamil Nadu</option>
						<option value="32">Tripura</option>
						<option value="33">Uttar Pradesh</option>    
						<option value="34">Uttarakhand</option>
						<option value="35">West Bengal</option>

					</select> 
					</div>
					<div class="large-4 columns">
					<input class="button tiny" type="submit" value="Search" />
					
					
					</div>

				</form>
				</div>
				</li>
				<hr />
<% List list = (List)request.getAttribute( "resultList" );
        
if(list!=null){

        out.print("<li id=\"numResults\" class=\"right\"> <strong>"+list.size()+"</strong> Results found</li>");
        out.print("<span class=\"clearfix\" ></span>");
        out.print("<div id=\"side_bar\" style=\"overflow-y: scroll;\">");
         

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
//out.print("<tr>");
//	out.print("<td><a href=\"#\">"+name+"</a></td>");
//out.print("</tr>");
%>
				<script >  
test.push(["<%= centername %>", <%= xcor %> , <%= ycor %> ,"<%= pin_db %>","<%= contact1 %>","<%= add1 %>" ]);
</script>
				<%
k++;
}

// out.print("</table>");
out.print("</div>");
} 
%>


			</ul>


		</div>

		<!-- Main Content Section -->
		<!-- This has been source ordered to come first in the markup (and on small devices) but to be to the right of the nav on larger screens -->
		<div class="large-8 columns">

			<h3>
				Map<small> Get the directions</small>
			</h3>

			<div id="map_canvas"></div>

		</div>

		
		<!-- Nav Sidebar -->
		<!-- This is source ordered to be pulled to the left on larger screens -->

		

	</div>


	<!-- Footer -->

	<footer class="row">
		<div class="large-12 columns">
			<hr />
			<div class="row">
				<div class="large-6 columns">
					<p>� Copyright no one at all. Go to town.</p>
				</div>
				<div class="large-6 columns">
					<ul class="inline-list right">
						<li><a href="index.jsp#aboutus">About Vaccinate</a></li>
						<li><a href="index.jsp#feedback">Feedback</a></li>
						<li><a href="faqs.html">FAQs</a></li>
						<li><a href="volunteer.html">Volunteer</a></li>
					</ul>
				</div>
			</div>
		</div>
	</footer>



	<!-- Modals -->
	<div id="mapModal" class="reveal-modal medium" data-reveal>
		<h3>Directions</h3>
		<div id="navMap" class="medium" style="height: 420px; width: 100%;"></div>
		<a class="close-reveal-modal">&#215;</a>
	</div>
	
	<!--  Modals -->    
    <div id="nameModal" class="reveal-modal small" data-reveal-style="display:none;opacity:1;visibility:hidden" data-reveal>
    	<h3> Please Enter your name</h3>
    	<input type="text" name="userName" placeholder="Your name here">
    	<a href="#" data-reveal-id="secondModal" class="button tiny">Submit</a>
    	<a class="close-reveal-modal">&#215;</a>    
    </div>
      <div id="secondModal" class="reveal-modal small" data-reveal-style="display:none;opacity:1;visibility:hidden" data-reveal>
    	
    	
    	<div>
	    	<div id="list"  class="grid_4"  style="overflow: auto;height:200px;background-color: lightblue">
				<div id="vaccibotBox"   style="color: black; background-color: lightblue">	
				<b>Vaccibot</b>: Hello. Please ask your query </br> 
				</div>
			</div>
		
			Say something here:
			<textarea  class="grid_4" style="color: grey; background-color: lightblue" name="comments" id="comments"></textarea>
			<a  class="link1" onclick="addText();">Submit</a>
			<a class="close-reveal-modal">&#215;</a>    
    	</div>
</div>



	<script src="js/jquery.js"></script>
	<script src="js/foundation.min.js"></script>
	<script src="js/foundation.topbar.js"></script>
	<script src="js/foundation.reveal.js"></script>
	<script>
      $(document).foundation();
      
      
      
      $('#mapModal').bind('opened', function(){
 	  		var currentCenter = dirMap.getCenter();  // Get current center before resizingM
 	    	  google.maps.event.trigger(dirMap, "resize");
 	    	  dirMap.setCenter(currentCenter); // Re-set previous center
 	    	  dirMap.setZoom(15);    	  
      });
    	  
    
    </script>
</body>
</html>
