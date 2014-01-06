<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.osahub.hcs.vaccinate.dao.registration.Person" %>
<%@ page import="com.osahub.hcs.vaccinate.dao.registration.Child" %>
<%@ page import="com.osahub.hcs.vaccinate.services.dataaccess.OfyService" %>
<%@ page import="com.osahub.hcs.vaccinate.util.DropdownUtil" %>

<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.images.Image" %>
<%@ page import="com.google.appengine.api.images.ImagesService" %>
<%@ page import="com.google.appengine.api.images.ImagesServiceFactory" %>
<%@ page import="com.google.appengine.api.images.Transform" %>
<%@ page import="com.google.appengine.api.blobstore.BlobKey" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="org.joda.time.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.Query" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>  
<%@ page import="com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter" %>  

<%@ page import="com.osahub.hcs.vaccinate.controller.admin.YoutubeBroadcastHandler" %>  
<%@ page import="com.osahub.hcs.vaccinate.bean.AppointmentBackingBean" %> 
<%@ page import="com.osahub.hcs.vaccinate.dao.user.AppointmentDao" %> 
<%@ page import="java.util.Iterator" %> 


<%!
	String typeString, mobile, lastLogin,username, name, hospitalId, userId ;
	Double xLat,yLon;
	VaccinationCenter p1;
	ArrayList<Child> childList;
	int childCount, type;
	UserService userService ;
	HttpSession session;
	String aevai;
	boolean noProfilePicture, noChildMonitored;
	List<AppointmentDao> appointmentList = null;
	AppointmentBackingBean appointmentBean = null;
	String image1_small;
	String childName,dateOfBirth ;
	LocalDate tikkaDate;
	AppointmentDao currentAppointment;
	
	

%>
<%	
	session = request.getSession();
	//for vacciMonitor
		

	BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	BlobKey blobKey;
	if(session.getAttribute("hospitalEmailId")!=null)
		userId = session.getAttribute("hospitalEmailId").toString();
	else
		response.sendRedirect("/index.jsp?status=3");
	
	try{
	  	userService = UserServiceFactory.getUserService();
		p1 = OfyService.ofy().load().type(VaccinationCenter.class).filter("email", userId).first().get();
		if(p1 == null){
			response.getWriter().println("log out your currently logged in google account and try again.");
		}else{
			if(p1.image1 != null){
				noProfilePicture =false;
	        	ImagesService imagesService = ImagesServiceFactory.getImagesService();
	        	image1_small = imagesService.getServingUrl(p1.image1);
			}else{
	        	noProfilePicture =true;
			}
			
			lastLogin = p1.lastLogin;
			name = p1.name;
			xLat=p1.xCor;
			yLon=p1.yCor;
			
			hospitalId = p1.id;
			
			
			//appointment history
				appointmentBean = new AppointmentBackingBean();
				appointmentList = appointmentBean.getAllAppointmentsByVacciCenterId(hospitalId);
				
			
			type = p1.type;
			typeString = DropdownUtil.GetVaccinationCenterTypeStringFromInt(type);
		
		}
	} catch(Exception e){
		e.printStackTrace();
		response.sendRedirect("/index.html?status=021"); //An error occured! please login again	
	} 
%>
<!DOCTYPE html>

<!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
	<script type="text/javascript" src="/_ah/channel/jsapi"></script>
      <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<meta charset="utf-8" />

	<!-- Set the viewport width to device width for mobile -->
	<meta name="viewport" content="width=device-width" />

	<title>Vaccinate : <%=typeString%> Home </title>

	<script language="javascript" src="user/javascripts/appointment.js"></script>
	<!-- Included CSS Files -->
  <link rel="stylesheet" href="user/stylesheets/app.css">
  <link rel="stylesheet" href="user/stylesheets/offcanvas.css">
  <link rel="stylesheet" href="user/stylesheets/foundation.css">
  <link rel="stylesheet" href="user/stylesheets/vaccinate.css">
  <link rel="stylesheet" href="user/stylesheets/googleapisfont.css">

  

  <script src="/user/javascripts/foundation/modernizr.foundation.js"></script>
  <!-- for date picker-->
  
	<script src="/user/script/jquery-1.9.1.js"></script>
	<script src="/user/script/jquery-ui.js"></script>
	<script src="/user/script/style1.js"></script>
	<script >
	$(function() {
	$( "#datepicker" ).datepicker();
	});
	</script>
	
	<!-- for google map functionality-->
   <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript">
  var map;
  var geocoder;
  var centerChangedLast;
  var reverseGeocodedLast;
  var currentReverseGeocodeResponse;
  var marker;
  var infowindow = new google.maps.InfoWindow();
  var latFromDB = <%=xLat%>;
  var lonFromDB = <%=yLon%>;
 
  var latlng
 var zoomLevel
  function initialize() {
    
    
      
      if(latFromDB.toString().length<2||lonFromDB.toString().length<2){
            zoomLevel = 5;
         latlng = new google.maps.LatLng(24.1089,77.41784);
      }
    else{
            zoomLevel = 13;
        
         latlng = new google.maps.LatLng(latFromDB,lonFromDB);
    }
        
    var myOptions = {
      zoom: zoomLevel,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    
      if(latFromDB.toString().length>1 && lonFromDB.toString().length>1)
            {
            
        marker= new google.maps.Marker({position:latlng,
                                         map:map,
                                         title:"we have your location"});
        
            }
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
          address = results[0].address_components;
          for (p = address.length-1; p >= 0; p--) {
              if (address[p].types.indexOf("postal_code") != -1) {
                  //alert(address[p].long_name);
        			document.getElementById("pincodeFromMap").value=address[p].long_name;
        			//alert("pin:"+document.getElementById("pincodeFromMap").value);
              }
          }
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
        address = results[0].address_components;
          for (p = address.length-1; p >= 0; p--) {
              if (address[p].types.indexOf("postal_code") != -1) {
                  //alert(address[p].long_name);
        			document.getElementById("pincodeFromMap").value=address[p].long_name;
        			alert("pin:"+document.getElementById("pincodeFromMap").value);
              }
          }
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


 
</script>
</head>

<body id="page" onload="initialize()">
<!-- Start Header and Nav -->
	<div class="row">
    	<div class="two columns">
    		<h1><img src="/user/images/logo.png" width="300" height="75"/></h1>
    	</div>
    
    
	    
	    <div class="ten columns" id = "nav-tab">
	      <dl class="tabs pill">
	      	<dd class="active"><a href="#start">Profile</a></dd>
			<dd ><a href="#main-content">Dashboard</a></dd>
			<dd><a href="#events">Events</a></dd>
			<dd><a href="<%=userService.createLogoutURL("/index.jsp")%>">Logout</a></dd>
			<a data-reveal-id="userHelpModal" href="">Help</a>
	      </dl>
	   </div>
	</div>
<!-- End Header and Nav -->
  

  <!-- First Band (Slider) -->
  <div class="row">
    <div class="twelve columns">
      <hr/>
      <h5>Welcome <%=name%></h3>
      <hr/ >
		<ul class="tabs-content ">  
				<li class="active"  id = "startTab"> 
        		<h3>Profile Information</h3>	
					<!--onsubmit="return checkform(this);")>-->
					<form  class="nice custom"  action="<%if(true) out.println(blobstoreService.createUploadUrl("/updateVaccinationCenter"));%>" enctype="multipart/form-data"  method="post" onsubmit="return checkform(this);")>
        			<fieldset>
        			<input type="hidden" id="action" name="action" value="updateVaccinationCenter" />
        			<input type="hidden" id="action" name="source" value="hospital" />
        			
    					<legend>General Detail</legend>
							<div class="row">
								<div class="six columns">
									<%
										if(noProfilePicture){
											out.println("<img alt=\"profile_picture\" src=\"/user/images/hospitalDefault.png\"/>");
										}else{
											out.println("<img alt=\"profile_picture\" src=\""+image1_small+"=s200\" />");
										}
									%>
        							<label for="myFile">Upload your vaccination center</label>
									<label for="image1_small" class="error" id="file1Error">Please choose an image for your vaccination center</label>
            						<input type="file" class="medium blue radius button" id="image1_small" placeholder="Small Product Image" name="image1_small">
        						</div>
								<div class="six columns">
									<div class="row">
										<div class="ten columns">
        									<label>Center Name <small>required</small></label>
        									<input type="text"  id="name" value="<%=p1.name%>" placeholder="Full Name" name = "name"/>
											<label for="name" class="error" id="nError">Please enter name in proper format</label>
        								</div>
        							</div>
									<div class="row">
										<div class="ten columns">
        									<label>Email ID</label>
        									<input type="text"  id="email" <%if(p1.refrence.equalsIgnoreCase("ONLINE"))out.println("readonly=\"readonly\"");%> value="<%=p1.email%>" placeholder="Email (optional)" name = "email"/>
											<label for="email" class="error" id = "eError">Please Enter Correct Email address</label>
        								</div>
        							</div>
        							<div class="row">
										<div class="ten columns">
        									<label>Contact Number1 <small> eg. for +91-120-2987654 enter 1202987654</small></label>
        									<input type="text" id="mobile1" maxlength="10" value="<%=p1.contact1%>" placeholder="Contact Number" name = "mobile1" />
											<label for="mobile1" class="error" id="m1Error">Please Enter contact number of 10 digit</label>
        								</div>
        							</div>
        							<div class="row">
										<div class="ten columns">
        									<label>Contact Number2 <small> eg. for +91-11-22598977 enter 1122598977</small></label>
        									<input type="text" id="mobile2"  maxlength="10" value="<%=p1.contact2%>" placeholder="Contact Number" name = "mobile2" />
											<label for="mobile2" class="error" id="m2Error">Please Enter contact number of 10 digit</label>
        								</div>
        							</div>
        							<div class="row">
										<div class="ten columns">
        									<label>Fax Number</label>
        									<input type="text" id="fax"  maxlength="10" value="<%=p1.fax%>" placeholder="Fax Number" name = "fax" />
											<label for="fax" class="error" id="faxError">Please Enter fax number of 10 digit</label>
        								</div>
        							</div>
        						</div>
        					</div>
        			</fieldset>
        			</br>
        			</br>
        			<fieldset>
    					<legend>Operational Details</legend>
    						<div class="row">
								<div class="four columns">
										<div class="twelve columns">
		        							<label>Working Hours</label>
		        							<input type="text" value="<%=p1.workingHours%>" id="workingHours" placeholder="eg. 10:00am - 9:30pm" name = "workingHours"/>
											<label for="workingHours" class="error" id="workingHoursError">Please enter working hours</label>
		        						</div>   
        						</div>
								<div class="three columns">
										<div class="twelve columns">
		        							<label>Weekly Holiday</label>
											<select name = "weaklyHoliday">
										        <option value="0">All Days Open</option>
										        <option value="1">Monday</option>
										        <option value="2">Tuesday</option>
										        <option value="3">Wednesday</option>
										        <option value="4">Thursday</option>
										        <option value="5">Friday</option>
										        <option value="6">Saturday</option>
										        <option value="7">Sunday</option>
											</select>
		        						</div> 
        						</div>
								<div class="five columns">
										<div class="twelve columns">
		        							<label>Type</label>
											<select name="vacciCenterType">
										        <option value="1">Govt. Hospital</option>
										        <option value="2">Charitable Hospital</option>
										        <option value="3">Non Govt. Organization</option>
										        <option value="4">Private Hospital</option>
										        <option value="5">Private Clinic</option>
											</select>
		        						</div> 
        						</div>
        					</div>
        					
        					
    						<div class="row">
								<div class="six columns">
										<div class="twelve columns">
		        							<label>Do you provide home vaccination service?</label>
		        							<input type="radio" name="homeServiceRadio" value="YES" id="pokemonRed"> Yes
											<input type="radio" checked name="homeServiceRadio" value="NO" id="pokemonBlue"> No
										</div>   
        						</div>
								<div class="six columns">
										<div class="twelve columns">
		        							<label>Range of home vaccination service</label>
											<select name="homeVaccinationRange">
										        <option value="1">Locality (1-5 Km)</option>
										        <option value="2">District (5-25 Km)</option>
										        <option value="3">City  (25-100 Km)</option>
										        <option value="4">State</option>
										        <option value="5">Country</option>
											</select>
		        						</div> 
        						</div>
        					</div>
							<div class="row">
    						<div class="row">
								<div class="twelve columns">
										<div class="twelve columns">
		        							<label>About Vacc. Center</label>
		        							<textarea name="aboutMe" id="aboutMe" placeholder="Description/Information about other facilities available at your vaccination center"><%=p1.aboutMe%></textarea>
											<label for="aboutMe" class="error" id="aboutMeError">Please enter some information about vaccination center</label>
		        						</div> 
		        						<!--  
										<div class="six columns">
		        							<label>About Vacc. Center</label>
		        							<textarea name="aboutMe" id="aboutMe" placeholder="Description/Information about vaccination center"></textarea>
											<label for="aboutMe" class="error" id="aboutMeError">Please enter some information about vaccination center</label>
		        						</div> 
										<div class="six columns">
		        							<label>Other Facilities</label>
		        							<textarea name"HospFacilities" id="HospFacilities" placeholder="Please enter other facilities available at your vaccination center"></textarea>
											<label for="HospFacilities" class="error" id="HospFacilitiesError">Please enter facilities</label>
		        						</div>
		        						-->   
        						</div>
        					</div>
								
        			</fieldset>
        			</br>
        			</br>
        			<fieldset>
    					<legend>Address Details</legend>
							<div class="row">
							<!--
								<div class="four columns">
									<div class="row">
										<div class="twelve columns">
		        							<label>Address Line 1</label>
		        							<input type="text" value="<%=p1.add1%>" id="addressLine1" placeholder="Address Line1 (optional)" name = "addressLine1"/>
											<label for="addressLine1" class="error" id="add1Error">Please enter addressLine1</label>
		        						</div>      						
		        					</div>
									<div class="row">
										<div class="twelve columns">
		        							<label>Locality</label>
		        							<input type="text" value="<%=p1.locality%>" id="locality" placeholder="Locality (optional)" name = "locality"/>
											<label for="locality" class="error" id="localityError">Please enter locality</label>
		        						</div>        						
		        					</div>
									<div class="row">
										<div class="twelve columns">
		        							<label>District</label>
		        							<input type="text"  id="district" value="<%=p1.district%>" placeholder="District (optional)" name = "district"/>
		        							<label for="district" class="error" id="districtError">Please enter district</label>
		        						</div>        						
		        					</div>
									<div class="row">
										<div class="twelve columns">
		        							<label>City</label>
						        			<input type="text"  id="city" value="<%=p1.city%>" placeholder="City (optional)" name = "city"/>
						        			<label for="city" class="error" id="cityError">Please enter district</label>
		        						</div>        						
		        					</div>
									<div class="row">
										<div class="twelve columns">
	        								<label>State</label>
						        			<input type="text"  id="state" value="<%=p1.state%>" placeholder="State (optional)" name = "state"/>
						        			<label for="state" class="error" id="stateError">Please enter a valid state</label>
		        						</div>        						
		        					</div>
									<div class="row">
										<div class="twelve columns">
	        								<label>PIN</label>
						        			<input type="text"  id="pin" maxlength="6"  value="<%=String.format("%06d",p1.pincode)%>" placeholder="PIN (optional)" name = "pin"/>
						        			<label for="pin" class="error" id="pinError">Please enter a valid pin number of 6 characters</label>
		        						</div>        						
		        					</div>
		        				
        						</div>
								<div class="eight columns">
								
  									Find Place: <input type="text" id="address"/><input type="button" value="Go" onclick="geocode()">
									<div id="map">
										<div id="map_canvas" style="width:100%; height:400px"></div>
									    <div id="crosshair"></div>
									</div>
        						</div>
        					-->
								<div class="one columns">
        						</div>
								<div class="ten columns">
									<div class="row">
										<div class="ten columns">
	        								<input type="text" id="address" placeholder="enter location to search" name = "address"/>
        								</div>
										<div class="two columns">
  											<input class="small blue radius button"  type="button" value="Go" onclick="geocode()">	
        								</div>
									
									</div>
									<div class="row">
										<div id="map">
											<div id="map_canvas" style="width:100%; height:600px"></div>
											<label for="address" class="error" id="addressError">Please choose correct location for your Vaccination center.</label>
										    <div id="crosshair"></div>
										</div>
									</div>
						
									
        						</div>
								<div class="one columns">
        						</div>
        					</div>
        			</fieldset>
        			
        			<br/>
					<input type="hidden" value="<%=hospitalId%>" name="hospitalId" />
					<input type="hidden" id="addressLine1" name="addressLine1" />
					<input type="hidden" id="pincodeFromMap" name="pincodeFromMap" />
					<input type="hidden" id="xCor" name="xCor" />
					<input type="hidden" id="yCor" name="yCor" />
        			<input type="submit" class="medium blue radius button" value="Update Information" />
        		</form>
			</li>
			<li id = "main-contentTab">
		  		<div class="row">
		  		
			  		<dl class="tabs" data-tab>
					  <dd class="active"><a href="#panel2-1">New Appointments</a></dd>
					  <dd><a href="#panel2-2">Approved Appointments</a></dd>
					  <dd><a href="#panel2-3">Appointments History</a></dd>
					</dl>
					<!-- 
					<div class="tabs-content">
					  <div class="content active" id="panel2-1">
					    <p>First panel content goes here...</p>
					  </div>
					  <div class="content" id="panel2-2">
					    <p>Second panel content goes here...</p>
					  </div>
					  <div class="content" id="panel2-3">
					    <p>Third panel content goes here...</p>
					  </div>
					</div>
					-->
					New Appointment
					<%
					if(appointmentList==null || appointmentList.size()==0)
						out.println("No New Appointment found");
					else{
						out.println("<form name =\"approveUser\" action=\"appointmentHandler\" method=\"post\" >");
						out.println("<input type=\"hidden\" id=\"source\" name=\"source\" value=\"hospital\" />");
						out.println("<input type=\"hidden\" id=\"action\" name=\"action\" value=\"approveAppointment\" />");
						out.println("<input type=\"hidden\" name=\"approveUserList\" id=\"approveUserList\">");
						out.println("<input type=\"hidden\" name=\"newApptActionList\" id=\"newApptActionList\">");
						out.println("<input type=\"hidden\" name=\"newApptCommentList\" id=\"newApptCommentList\">");

						
								
						out.println("<table><thead><tr><th></th><th>Created On</th><th>Appt. Date</th><th>Parent Details</th><th>Action</th><th width=\"150\">Comments</th></tr></thead><tbody>");
						Iterator<AppointmentDao> dd =  appointmentList.iterator();
						int i = 1;
						while(dd.hasNext()){
							currentAppointment = dd.next();
							if(currentAppointment.status == 1)
							out.println("<tr><td><input type=\"checkbox\" name=\"approveMob\" id=\"approveMob\" value=\""+
								currentAppointment.appointmentId+"\" /></td><td>"+
								currentAppointment.createdOn+"</td><td>"+
								currentAppointment.appointmentDate+"</td><td>Name : "+
								currentAppointment.patientName+"<br>Contact : "+
								currentAppointment.patientContact+"<br>Email : "+
								currentAppointment.patientId+"</td><td><select id=\"newApptAction\" name=\"newApptAction\"><option value=\"2\">Accept</option><option value=\"3\">Reject</option></select></td><td><textarea id=\"newApptComment\" name=\"newApptComment\" ></textarea></td></tr>");
								i++;
						}
						out.println("</tbody></table>");
						out.println("<input type=\"submit\" onclick=\"return approve1()\" class=\"medium blue radius button\" value=\"Submit\" />");
						out.println("</form>");
					}
				%>
				Accepted Appointment
				<%
				if(appointmentList==null || appointmentList.size()==0)
					out.println("No Accepted Appointment found");
				else{
						out.println("<form name =\"closeUser\" action=\"appointmentHandler\" method=\"post\" >");
						out.println("<input type=\"hidden\" id=\"source\" name=\"source\" value=\"hospital\" />");
						out.println("<input type=\"hidden\" id=\"action\" name=\"action\" value=\"closeAppointment\" />");
						out.println("<input type=\"hidden\" name=\"closeUserList\" id=\"closeUserList\">");
						out.println("<input type=\"hidden\" name=\"acceptedApptActionList\" id=\"acceptedApptActionList\">");
						out.println("<input type=\"hidden\" name=\"acceptedApptCommentList\" id=\"acceptedApptCommentList\">");
					out.println("<table><thead><tr><th></th><th>Created On</th><th>Appt. Date</th><th>Parent Details</th><th>Action</th><th width=\"150\">Comments</th></tr></thead><tbody>");
					Iterator<AppointmentDao> dd =  appointmentList.iterator();
					int i = 1;
					while(dd.hasNext()){
						currentAppointment = dd.next();
						if(currentAppointment.status == 2)
						out.println("<tr><td><input type=\"checkbox\" name=\"closeMob\" id=\"closeMob\" value=\""+
								currentAppointment.appointmentId+"\" /></td><td>"+
							currentAppointment.createdOn+"</td><td>"+
							currentAppointment.appointmentDate+"</td><td>Name : "+
							currentAppointment.patientName+"<br>Contact : "+
							currentAppointment.patientContact+"<br>Email : "+
							currentAppointment.patientId+"</td><td><select id=\"acceptedApptAction\" name=\"acceptedApptAction\"><option value=\"4\">Close</option><option value=\"3\">Reject</option></select></td><td><textarea id=\"acceptedApptComment\" name=\"acceptedApptComment\" ></textarea></td></tr>");
							i++;
					}
					out.println("</tbody></table>");
						out.println("<input type=\"submit\" onclick=\"return close1()\" class=\"medium blue radius button\" value=\"Submit\" />");
						out.println("</form>");
				}
			%>
					Appointment History
					<%
						if(appointmentList==null || appointmentList.size()==0)
							out.println("No history found");
						else{
							out.println("<table><thead><tr><th>S.No.</th><th>Created On</th><th>Appt. Date</th><th>Parent Details</th><th>Status</th><th width=\"150\">Comments</th></tr></thead><tbody>");
							Iterator<AppointmentDao> dd =  appointmentList.iterator();
							int i = 1;
							while(dd.hasNext()){
								currentAppointment = dd.next();
								out.println("<tr><td>"+
									i+"</td><td>"+
									currentAppointment.createdOn+"</td><td>"+
									currentAppointment.appointmentDate+"</td><td>Name : "+
									currentAppointment.patientName+"<br>Contact : "+
									currentAppointment.patientContact+"<br>Email : "+
									currentAppointment.patientId+"</td><td>"+
									DropdownUtil.GetAppointmentStatusStringFromInt(currentAppointment.status)+"</td><td>"+
									currentAppointment.notes+"</td></tr>");
									i++;
							}
							out.println("</tbody></table>");
						}
					%>
				</div>
				<div class="row">	
				</div> 
	      	</li>
	      	
	      	<li id ="eventsTab">
				
				<div class="row">
					
				</div>
			</li>
	    
   
	  </ul>
	  
	  </div>
	  </div>
 
  
  <!-- Footer -->
  
  <footer class="row">
    <div class="twelve columns">
      <hr />
      <div class="row">
        <div class="six columns">
          <p>&copy; Vaccinate 2013</p>
        </div>
        <div class="six columns">
          <ul class="link-list right">
            <li><%=lastLogin%></li>
          </ul>
        </div>
      </div>
    </div> 
  </footer>
 

	<!-- Modal windows hidden -->
	
	
	<div id="userHelpModal" class="reveal-modal large">
	<h2><%=typeString%> Help</h2>
	<iframe src="https://docs.google.com/a/osahub.com/file/d/0B32gCB8YogDZd2pCUkVxdmpfbUk/preview" width="100%" height="385"></iframe>
	</div>
	<a class="close-reveal-modal">&#215;</a>
	</div> 
	

	<!-- modal window for success -->
	
	<div id ="successProfileUpdateModal" class="reveal-modal medium">
		<h2>Congrats!</h2>
		<p>Your information has been updated successfully</p>
	</div>
	
	<div id ="successChildAddModal" class="reveal-modal medium">
		<h2>Congrats!</h2>
		<p>You have successfully registered a child .</p>
	</div>
	
	<div id ="errorChildAddModal1" class="reveal-modal medium">
		<h2>Error!</h2>
		<p>Something went wrongwhile adding a child . Please try again.</p>
	</div>
	
	<div id ="errorChildAddModal2" class="reveal-modal medium">
		<h2>Error!</h2>
		<p>You can not add more then 5 child.</p>
	</div>
	
	<div id ="successNewAppointmentSubmit" class="reveal-modal medium">
		<h2>Success!</h2>
		<p>You have successfully updated the appointments.</p>
	</div>
	
	<div id ="successAcceptedAppointmentSubmit" class="reveal-modal medium">
		<h2>Success!</h2>
		<p>You have successfully closed the appointments.</p>
	</div>
	
	
	<div id="privacyModal" class="reveal-modal small">
		<h3>Our Privacy Policy</h3>
		<hr/>
		<p>We do not and will not share your data with anyone. Period.</p>
		<div class="small blue button close-modal">Close</div>
	</div>
	
	
	
	
	
	
	<div id="verifyUnauthorizeAccess" class="reveal-modal medium">
		<h3>Login Error!</h3>
			<hr/>
			<p>
		<h5 class="red">You are not authorized to access this section.<a href="/logout"> Click here</a> to try again.</h5><br\></p>
		<div class="small blue button close-modal">Close</div>
	</div>
	
	<div id="verifyUnexpectedError" class="reveal-modal medium">
		<h3>Error while validating!</h3>
			<hr/>
			<p>
		<h5 class="red">You are not authorized to access this section.<a href="/logout"> Click here</a> to try again.</h5><br\></p>
		<div class="small blue button close-modal">Close</div>
	</div>
	


	<!-- Included JS Files -->
  <script src="user/javascripts/foundation/jquery.js"></script>
  <script src="user/javascripts/foundation/jquery.foundation.reveal.js"></script>
  <script src="user/javascripts/foundation/jquery.foundation.orbit.js"></script>
  <script src="user/javascripts/foundation/jquery.foundation.forms.js"></script>
  <script src="user/javascripts/foundation/jquery.placeholder.js"></script>
  <script src="user/javascripts/foundation/jquery.foundation.tooltips.js"></script>
  <script src="user/javascripts/foundation/jquery.foundation.alerts.js"></script>
  <script src="user/javascripts/foundation/jquery.foundation.buttons.js"></script>
  <script src="user/javascripts/foundation/jquery.foundation.accordion.js"></script>
  <script src="user/javascripts/foundation/jquery.foundation.navigation.js"></script>
  <script src="user/javascripts/foundation/jquery.foundation.mediaQueryToggle.js"></script>
  <script src="user/javascripts/foundation/jquery.foundation.tabs.js"></script>
  <script src="user/javascripts/foundation/jquery.offcanvas.js"></script>
  <script src="user/javascripts/foundation/app.js"></script>
  <!-- Put this above your </body> tag -->
<script type="text/javascript">
$(window).load(function() {
	$('.close-modal').click(function(){
		$('.close-modal').trigger('reveal:close');
	});
	
    $('#slider').orbit({
    	animationSpeed:1200,
    	advanceSpeed:5000
    	 	});
    
    
  });

function getParameterByName(name){
	  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
	  var regexS = "[\\?&]" + name + "=([^&#]*)";
	  var regex = new RegExp(regexS);
	  var results = regex.exec(window.location.search);
	  if(results == null)
	    return "";
	  else
	    return decodeURIComponent(results[1].replace(/\+/g, " "));
	}
	

 
  
  $(document).ready(function(){
	 //$('.numbers') .forcenumeric();
		$('.error').hide();
		var status = getParameterByName('status')
		
		//profile updated succefully 
		if(status == '100'){
			$('#successProfileUpdateModal').reveal();
		}
		
		//child added succefully 
		if(status == '101'){
			$('#successChildAddModal').reveal();
		}
		
		//error while adding child  
		if(status == '102'){
			$('#errorChildAddModal1').reveal();
		}
		
		//error while adding child  
		if(status == '103'){
			$('#errorChildAddModal2').reveal();
		}
		
		//success  while updating New Appointments  
		if(status == '105'){
			$('#successNewAppointmentSubmit').reveal();
		}
		
		//success  while updating Accepted Appointments  
		if(status == '106'){
			$('#successAcceptedAppointmentSubmit').reveal();
		}
		
		if(status == '001'){
			$('#successModal').reveal();
		}
		if(status == '000'){
			$('#errModal').reveal();
		}
		if(status == '002'){
			$('#UnsubscribeModal').reveal();			
		}
		if(status == '003'){
			$('#deleteUserModal').reveal();
		}
		if(status == '005'){
			$('#feedbackRecdModal').reveal();
		}
		if(status == '009'){
			$('#invalidEmailModal').reveal();
		}
		if(status == '010'){
			$('#verifySuccessModal').reveal();
		}
		if(status == '011'){
			$('#verifyInvalidHashModal').reveal();
		}
		if(status == '012'){
			$('#verifyNotRegisteredModal').reveal();
		}
		if(status == '013'){
			$('#verifyInvalidHash2Modal').reveal();
		}
		if(status == '014'){
			$('#verifyChildLimitExceeded').reveal();
		}
		if(status == '015'){
			$('#verifyUnauthorizeAccess').reveal();
		}
		if(status == '016'){
			$('#verifyUnexpectedError').reveal();
		}
		if(status == '017'){
			$('#verifyInvalidHash').reveal();
		}
		if(status == '018'){
			$('#verifyValidated').reveal();
		}
		if(status == '019'){
			$('#verifyLogin').reveal();
		}
		if(status == '020'){
			$('#verifyRegister').reveal();
		}
		
		
		
		$('.backJob').click(function(){
			$('#backJobModal').reveal();
			
		});
		
		
		
  });
  
 function isEmail(email){
	  var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	  return regex.test(email);
 }
 
 function isNumeric(num){
	 var regex = /^[0-9]+$/
	 return regex.test(num);
 }
  
 
 function checkFForm(){
	 $('.error').hide();

	//check for name
	 if($('#fName').val().length<3 || isNumeric($('#fName').val())){
			$('#fNameError').show();
			return false;
	}
		
	//check for email
	 if($('#fEmail').val().length<3 || !isEmail($('#fEmail').val())){
		$('#fEmailError').show();
		return false;
	}
		
	//check for number
	 if($('#fNumber').val().length<10 || $('#fNumber').val().length>12 || !isNumeric($('#fNumber').val())){
			$('#fNumberError').show();
			return false;
	}

	//check for message
	if($('#fQuery').val().length<3){
		 $('#fQueryError').show();
		 return false;
	 }
 }
 
 //back office form validation
 function checkBackForm(){
	 
	 $('.error').hide();
	 if($('#bEmail').val().length>3){
		 if(!isEmail($('#bEmail').val())){
			  $('#bEmailError').show();
			  return false;
		  }
	 }
	 else{
		 $('#bEmailError').show();
		 return false;
	 }
	 
	 
 } 
 
 //login form validation
 function checkLoginForm(){
 	  $('.error').hide();
 	  //check username
 	  if($('#username').val().length>2){
 			  
 		  if(!isEmail($('#username').val())){
 			  $('#eUsername').show();
 			  return false;
 		  }
 	  }else{
 			  $('#eUsername').show();
 			  return false;
 		  }		  
 	  
 	//check password
 	var mobile = $('#password').val();
 	
 	if(mobile.length < 8 ){
		$('#ePassword').show();
		return false;
 	}
 	  	
 	return true;
 }
 
  //registration forms validation
function checkform(){
	  $('.error').hide();
	  //check if name is valid and doesnot contain digits.
	  if($('#name').val().length<10 || isNumeric($('#name').val())){
		  $('#nError').show();
		  return false;
	  }
	  
	//check pin number
	
	  
	  //check email
	  if($('#email').val().length>0 && !isEmail($('#email').val())){
		  $('#eError').show();
		  return false;
	  }	  
	  
	//check mobile number and its not optional
	var mobile1 = $('#mobile1').val();
	if(mobile1.length != 10 || (mobile1.length == 10 && !isNumeric(mobile1))){
		$('#m1Error').show();
		return false;
	}  
	  
	//check mobile number and its  optional
	var mobile2 = $('#mobile2').val();
	if((mobile2.length > 0 && mobile2.length < 10 ) || (mobile2.length == 10 && !isNumeric(mobile2))){
		$('#m2Error').show();
		return false;
	}  
	  
	//check fax number and its  optional
	var fax = $('#fax').val();
	if((fax.length > 0 && fax.length < 10 ) || (fax.length == 10 && !isNumeric(fax))){
		$('#faxError').show();
		return false;
	}  
 
 
	
	
	  //check if workingHours are entered or not
	  if($('#workingHours').val().length<8 ){
		  $('#workingHoursError').show();
		  return false;
	  }
	
	
	  //check if aboutMe is filled or not
	  if($('#aboutMe').val().length<4 ){
		  $('#aboutMeError').show();
		  return false;
	  }
	
	
	 
	   

	//Address checks
	
	//google maps Address check
	if($('#addressLine1').val() == null  || $('#addressLine1').val().length<1 ){
		$('#addressError').show();
		return false;
	}
	
	return true;
}
  

 
  //child registration forms validation
function checkchildform(){
	  $('.error').hide();
  	//check Child's name
  	if($('#cName').val().length<3){
		  $('#cNError').show();
		  return false;
	  }
  	
  	//check day
  	dday = $('#ddob').val();
  	mday = $('#mdob').val();
  	yday = $('#ydob').val();
  	
  	
  	
  	if(!isNumeric(dday) || dday<1 || dday >31 || dday.length<1){
  		$('#dobError').show();
  		return false;
  	}
  	
  	
  	if(!isNumeric(mday) || mday<1 || mday >12 || mday.length <1){
  		$('#dobError').show();
  		return false;
  	}
  	
  	if(!isNumeric(yday) || yday<2001 || yday >2013 || yday.length<4){
  	    $('#dobError').show();
  		return false;
  	}
	return true;
}
	
	
</script>
  
  

</body>