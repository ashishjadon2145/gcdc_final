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
<%@ page import="java.util.Iterator" %> 
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

<%@ page import="com.osahub.hcs.vaccinate.controller.admin.YoutubeBroadcastHandler" %>
<%@ page import="com.osahub.hcs.vaccinate.bean.AppointmentBackingBean" %> 
<%@ page import="com.osahub.hcs.vaccinate.dao.user.AppointmentDao" %> 
 



<%!
	String roleString, mobile, lastLogin,username, name, registrarEmail, userId;
	Person p1;
	ArrayList<Child> childList;
	int childCount, role;
	UserService userService ;
	HttpSession session;
	String aevai;
	boolean noProfilePicture, noChildMonitored;
	String image1_small;
	String childName,dateOfBirth ;
	LocalDate tikkaDate;
	List<AppointmentDao> appointmentList = null;
	AppointmentBackingBean appointmentBean = null;
	AppointmentDao currentAppointment;
	
public String getFormattedDate(String tikkaDate){
	String formattedDate="";
	formattedDate = tikkaDate.substring(5, 7)+"/"+tikkaDate.substring(8, 10)+"/"+tikkaDate.substring(0, 4);
	return  formattedDate;
} 
public String getBirthDate(String tikkaDate){
	String formattedDate="";
	formattedDate = tikkaDate.substring(3, 5)+"/"+tikkaDate.substring(0, 2)+"/"+tikkaDate.substring(6, 10);
	return  formattedDate;
} 
%>
<%	
	session = request.getSession();
	//for vacciMonitor
	if(session.getAttribute("childName")!=null && session.getAttribute("dateOfBirth")!=null ){
		noChildMonitored = false;
		childName = session.getAttribute("childName").toString();
		dateOfBirth = session.getAttribute("dateOfBirth").toString();
		tikkaDate = new LocalDate(dateOfBirth.substring(0,4)+"-"+dateOfBirth.substring(5,7)+"-"+dateOfBirth.substring(8,10));
	}
	else{
		noChildMonitored = true;
	}
		

	BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	BlobKey blobKey;
	if(session.getAttribute("userId")!=null)
		userId = session.getAttribute("userId").toString();
	else
		response.sendRedirect("/error3.html");
	
	try{
	  	userService = UserServiceFactory.getUserService();
		p1 = OfyService.ofy().load().type(Person.class).id(userId).get();
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
			mobile= p1.mobile;
			username = p1.userName;
			
			childCount = p1.childCount;
			registrarEmail = p1.email;
			if(childCount > 0){
				childList = new ArrayList<Child>();
				childList = com.osahub.hcs.vaccinate.controller.register.UpdateProfile.getChildListFromParentEmail(registrarEmail);
				childCount = childList.size();
			}
				
			//appointment history
				appointmentBean = new AppointmentBackingBean();
				appointmentList = appointmentBean.getAllAppointmentsByPatientId(userId);
			
			role = p1.role;
			roleString = DropdownUtil.GetRoleStringFromInt(role);
		
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

	<title>Vaccinate : <%=roleString%> Home </title>

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
	<script type="text/javascript" charset="utf-8">
                //handle incoming chat messages, pushed by App Engine
                function onMessage(message) {
                        var current = $('textarea').val();
                       
                        //var so
                        message && $('textarea').val(current + '\n' + message.data);
                }
        
                //Initialize our little chat application
                $(function() {
                
                        
                        //Get a client token to use with the channel API
                        $.ajax('/chat',{
                                method:'GET',
                                dataType:'text',
                                success: function(token) {
                                        console.log(token);
                                        var channel = new goog.appengine.Channel(token);
                                        var socket = channel.open();
                                        
                                        //Assign our handler function to the open socket
                                        socket.onmessage = onMessage;
                                }
                        });
                        
                        //handle submitting chat message for youtube broadcast
                        function submitMessage() {
                                $.ajax('/chat2', {
                                        method:'POST',
                                        dataType:'text',
                                        data: {
                                                message:$('#kutta').val(),
                                                chatUserId :kameeen
                                        },
                                        success:function(response) {
                                                $('input').val('').focus();
                                                console.log(response);
                                        }
                                });
                        }
                        
                       
                        
                        //Attach event handlers
                        $('button').on('click', submitMessage);
                        
                });
        </script>
	<script  >
	$(function() {
	$( "#datepicker" ).datepicker();
	});
	
	
	</script>
	<!--<link rel="stylesheet" href="/css/style.css" />-->
</head>

<body id="page" >
<!-- Start Header and Nav -->
	<div class="row">
    	<div class="two columns">
    		<h1><img src="/user/images/logo.png" width="300" height="75"/></h1>
    	</div>
    
    
	    
	    <div class="ten columns" id = "nav-tab">
	      <dl class="tabs pill">
	      	<dd class="active"><a href="#start">Profile</a></dd>
			<dd ><a href="#main-content">VacciMonitor</a></dd>
			<dd><a href="#liveConsult">Live Consult & Chat</a></dd>
			<dd><a href="#homeConsult">Vacci @ Home</a></dd>
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
      <h5>Welcome <%=name%>.</h3>
     
      	<script>
	 	var kameeen = '<%=username%>';
	 	</script>
	  <hr/ >
		<ul class="tabs-content ">  
				<li class="active"  id = "startTab"> 
        		<h3>Profile Information</h3>	
					<!--onsubmit="return checkform(this);")>-->
					<form  class="nice custom"  action="<%if(true) out.println(blobstoreService.createUploadUrl("/updateProfile"));%>" enctype="multipart/form-data"  method="post" onsubmit="return checkform(this);")>
        			<fieldset>
        			<input type="hidden" id="action" name="action" value="updatePersonDetails" />
        			<input type="hidden" id="action" name="source" value="parent" />
        			
    					<legend>Personal Detail</legend>
							<div class="row">
								<div class="six columns">
									<%
										if(noProfilePicture){
											out.println("<img alt=\"profile_picture\" src=\"/user/images/parentDefault.jpg\"/>");
										}else{
											out.println("<img alt=\"profile_picture\" src=\""+image1_small+"=s200\" />");
										}
									%>
        							<label for="myFile">Change your profile picture</label>
									<label for="image1_small" class="error" id="file1Error">Please choose an image for your profile</label>
            						<input type="file" class="medium blue radius button" id="image1_small" placeholder="Small Product Image" name="image1_small">
        						</div>
								<div class="six columns">
									<div class="row">
										<div class="ten columns">
        									<label>Name <small>required</small></label>
        									<input type="text"  id="name" value="<%=p1.name%>" placeholder="Full Name" name = "name"/>
											<label for="name" class="error" id="nError">Please enter name in proper format</label>
        								</div>
        							</div>
									<div class="row">
										<div class="ten columns">
        									<label>Email ID</label>
        									<input type="text"  id="email" readonly="readonly" value="<%=p1.email%>" placeholder="Email (optional)" name = "email"/>
											<label for="email" class="error" id = "eError">Please Enter Correct Email address</label>
        								</div>
        							</div>
        							<div class="row">
										<div class="ten columns">
        									<label>Contact Number</label>
        									<input type="text" id="mobile" value="<%=p1.mobile%>" placeholder="Mobile Number" name = "mobile" />
											<label for="mobile" class="error" id="mError">Please Enter mobile number of 10 digit</label>
        								</div>
        							</div>
        						</div>
        					</div>
        			</fieldset>
        			</br>
        			</br>
        			<fieldset>
    					<legend>Address Details</legend>
							<div class="row">
								<div class="four columns">
        							<label>Address Line 1</label>
        							<input type="text" value="<%=p1.addressLine1%>" id="addressLine1" placeholder="Address Line1 (optional)" name = "addressLine1"/>
									<label for="addressLine1" class="error" id="naddressLine1">Please enter addressLine1</label>
        						</div>
								<div class="four columns">
        							<label>Locality</label>
        							<input type="text" value="<%=p1.locality%>" id="locality" placeholder="Locality (optional)" name = "locality"/>
									<label for="locality" class="error" id="localityError">Please enter locality</label>
        						</div>
								<div class="four columns">
        							<label>District</label>
        			<input type="text"  id="district" value="<%=p1.district%>" placeholder="District (optional)" name = "district"/>
        			<label for="district" class="error" id="districtError">Please enter district</label>
        						</div>
        						
        					</div>
							<div class="row">
								<div class="four columns">
        							<label>City</label>
        			<input type="text"  id="city" value="<%=p1.city%>" placeholder="City (optional)" name = "city"/>
        			<label for="city" class="error" id="cityError">Please enter district</label>
        						</div>
								<div class="four columns">
        							<label>State</label>
        			<input type="text"  id="state" value="<%=p1.state%>" placeholder="State (optional)" name = "state"/>
        			<label for="state" class="error" id="stateError">Please enter a valid state</label>
        						</div>
								<div class="four columns">
        							<label>PIN</label>
        			<input type="text" maxlength="6"   id="pin" value="<%=String.format("%06d",p1.pin)%>" placeholder="PIN (optional)" name = "pin"/>
        			<label for="pin" class="error" id="pinError">Please enter a valid pin number of 6 characters</label>
        						</div>
        					</div>	
        			</fieldset>
        			
        			 
        	
        			<!--
        			<label for="tAndC2" class="error" id="tAndC2Error">Please rechecked the details once.</label>
        			<input type="checkbox" class="input-text four" id="tAndC2" name = "tAndC2" />
        			I have rechecked the details.
        			<br/>
        			-->
        			<br/>
					<input type="hidden" value="<%=registrarEmail%>" name="registrarEmail" />
					<input type="hidden" value="<%=mobile%>" name="registrarNumber" />
        			<input type="submit" class="medium blue radius button" value="Update Profile Information" />
        		</form>
					
					
        		
			</li>
		
			<li id = "main-contentTab">
		  		<div class="row">
		  		<%
		  			if(childCount == 0)
						out.println("<h4>You do not have any children registered with us.</h4>");
					else{
						
					out.println("<div class=\"six columns\">");
					out.println("<form class=\"nice custom\" action= \"updateProfile\" method=\"post\" onsubmit =\"\">");
						out.println("<input type=\"hidden\" id=\"action\" name=\"action\" value=\"startMonitorChild\" />");
        				out.println("<input type=\"hidden\" id=\"action\" name=\"source\" value=\"parent\" />");
					out.println("<fieldset>");
        					out.println("<legend>Monitor a Child <//legend>");
								out.println("<div class=\"row\">");
									out.println("<div class=\"ten columns\">");
        								out.println("<label>Select child<//label>");	
										out.println("<select  id=\"childId\" name=\"childId\">");
											for(Child c : childList){
												out.println("<option value=\""+c.dob+c.name+"\">"+c.name+"<//option>");
											}
										out.println("</select>");
        							out.println("</div>");
        						out.println("</div>");
						
						out.println("<input type=\"submit\" class=\"medium blue radius button\" value=\"Start Monitoring\"/>");
						out.println("</fieldset>");
					out.println("</form>");
					out.println("</div>");
					}
		  		%>
		  		
					
					
					<!--onsubmit="return checkchildform(this);")> -->
						<form  class="nice custom" action="updateProfile" method="post" onsubmit="return checkchildform(this);")>
					<fieldset>
        					<legend>Add a Child </legend>
								<input type="hidden" id="action" name="action" value="addChild" />
        						<input type="hidden" id="action" name="source" value="parent" />
								<div class="row">
									<div class="six columns">
        								<label>Child name</label>
        								<input type="text" id="cName" placeholder = "Child's name" name = "cName" />
        								<label for="cName" maxlength="50" class="error" id="cNError">Please enter  child's name</label>
        							</div>
        						</div>
        						<!--
								<div class="row">
									<div class="six columns">
        								<label>Child's Date Of Birth</label>
        								<label for="datepicker" class="error" id="cDError">Please enter  child's DOB</label>
        								<input type="text" id="datepicker" placeholder = "Child's DOB" name = "datepicker" />
        							</div>
        						</div>
        						-->
        						<div class="row" id ="children">
        								<label>Child's DOB in DD/MM/YYYY format</label>
        							<div class="eight columns">
		        					<div class="four columns ">
		        						<label for="mdob" class="error" id="mbError">Please Enter correct month</label>
		        						<input type="text" maxlength="2" id="mdob" placeholder="MM" name="mdob"/>
		        					</div>
		        					<div class="four columns pull-two">
		        						<label for ="ddob" class="error" id = "dbError">Please Enter correct Date</label>
		        						<input type="text" maxlength="2" id="ddob" placeholder="DD" name ="ddob"/>
		        					</div>
		        					<div class="four columns pull-three">
		        						<label for="ydob" class="error" id="ybError">Please Enter correct year</label>
		        						<input type="text" maxlength="4" id="ydob" placeholder="YYYY" name="ydob"/>
		        					</div>
        							</div>
        				
        						<div class="four columns pull-four">
        							<label class="error" id ="dobError">Please enter correct date of birth </label>
        						</div>
	        	
        			</div>
        			<!--
        			<label for="tAndC" class="error" id="tAndCError">Please rechecked the details once.</label>
        			<input type="checkbox" class="input-text four" id="cName" name = "tAndC" />
        			I have rechecked the details.
        			<br/>
        			-->
        			<br/>
					<input type="hidden" value="<%=registrarEmail%>" name="registrarEmail" />
					<input type="hidden" value="<%=mobile%>" name="registrarNumber" />
        			<input type="submit" class="medium blue radius button" value="Add Child" />
        			
					</fieldset>
        		</form>	
				
		  		<%
		  			if(!noChildMonitored)
		  			{
				 out.println("<table class=\"pretty-table\" background=\"\\images\\logo2.png\" width=\"900\"  align=\"center\">");
				  out.println("<thead>");
				        out.println("<tr>");
				    out.println("<th scope=\"col\" colspan=\"2\" align=\"center\"   >Child Name</th>");
				    out.println("<th scope=\"col\" colspan=\"2\" align=\"center\"   >"+childName+"</th>");
				    out.println("</tr>");
				  out.println("</thead>");
				 
				  out.println("<thead>");
				  out.println("<tr>");
				    out.println("<th colspan=\"2\" align=\"center\"   >Date of Birth</th>");
				    out.println("<th colspan=\"2\" align=\"center\"   >"+getFormattedDate(tikkaDate.toString())+"</th>");
				  out.println("</tr>");
				  out.println("</thead>");
				  out.println("<td></td><td></td><td></td><td></td>");
				  out.println("<thead>");
				  out.println("<tr>");
				    out.println("<th width=\"143\" align=\"center\"   ><font face=\"arial\" size=\"3\" >Age</th>");
				    out.println("<th width=\"143\" align=\"center\"   ><font face=\"arial\" size=\"3\" >DUE DATE</th>");
				    out.println("<th width=\"143\" align=\"center\"   ><font face=\"arial\" size=\"3\" >VACCINE</th>");
				    out.println("<th width=\"143\" align=\"center\"   ><font face=\"arial\" size=\"3\" >Comments</th>");
				    out.println("</tr>");
				  out.println("</thead>");
				 
				  out.println("<tr>");
				  out.println("  <td align=\"center\"   ><font face=\"arial\" size=\"3\"   ><b>Birth</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>B.C.G.</br>Hep-B 1</b></font></td>");
				    out.println("<td align=\"center\"   ></font></td>");
				  out.println("</tr>");
				  out.println("<tr>");
				    out.println("<td align=\"center\"   ><b>6 weeks</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.plusDays(42).toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>DTP 1</br>IPV 1</br>Hep-B 2</br>Hib 1</br>Rotavirus 1</br>PCV 1</b></font></td>");
				    out.println("<td align=\"left\"   ><b>Polio</b> : Use IPV. But may be replaced with OPV if former is unaffordable/unavailable</br><b>Rotavirus</b> : 2 doses of RV-1 and 3 doses of RV-5</font></td>");
				  out.println("</tr>");
				  out.println("<tr>");
				    out.println("<td align=\"center\"   ><b>10 weeks</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.plusDays(70).toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>DTP 2</br>IPV 2</br>Hib 2</br>Rotavirus 2</br>PCV 2</b></font></td>");
				    out.println("<td align=\"center\"   ></font></td>");
				  out.println("</tr>");
				  out.println("<tr>");
				    out.println("<td align=\"center\"   ><b>14 weeks</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.plusDays(98).toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>DTP 3</br>IPV 3</br>Hib 3</br>Rotavirus 3</br>PCV 3</b></font></td>");
				    out.println("<td align=\"left\"   ><b>Rotavirus</b> : Only 2 doses of RV1 are recommended at present.</font></td>");
				  out.println("</tr>");
				  out.println("<tr>");
				    out.println("<td align=\"center\"   ><b>6 months</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.plusMonths(6).toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>OPV 1 </br>Hep-B 3</b></font></td>");
				    out.println("<td align=\"left\"   ><b>Hepatitis-B</b> : The final (third or fourth) dose in the HepB vaccine series should be administered no earlier than age 24 weeks and at least 16 weeks after the first dose.  </font></td>");
				  out.println("</tr>");
				  out.println("<tr>");
				    out.println("<td align=\"center\"   ><b>9 months</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.plusMonths(9).toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>OPV 2</br>Measles</b></font></td>");
				    out.println("<td align=\"left\"   ><b></b>  </font></td>");
				  out.println("</tr>");
				  out.println("<tr>");
				    out.println("<td align=\"center\"   ><b>12 months</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.plusMonths(12).toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>Hep-A 1</b></font></td>");
				    out.println("<td align=\"left\"   ><b>Hepatitis A</b> : For both killed and live hepatitis-A vaccines, 2 doses are recommended</font></td>");
				  out.println("</tr>");
				  out.println("<tr>");
				    out.println("<td align=\"center\"   ><b>15 months</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.plusMonths(15).toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>MMR 1</br>Varicella 1</br>PCV booster</b></font></td>");
				    out.println("<td align=\"left\"   ><b>Varicella</b> : The risk of breakthrough varicella is lower if given 15 months onwards.</font></td>");
				  out.println("</tr>");
				  out.println("<tr>");
				    out.println("<td align=\"center\"   ><b>16-18 months</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.plusMonths(16).toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>DTP B1</br>IPV B1</br>Hib B1</b></font></td>");
				    out.println("<td align=\"left\"   >The first booster (4thth dose) may be administered as early as age 12 months, provided at least 6 months have elapsed since the third dose.</font></td>");
				  out.println("</tr>");
				  out.println("<tr>");
				    out.println("<td align=\"center\"   ><b>18 months</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.plusMonths(18).toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>Hep-A 2</b></font></td>");
				    out.println("<td align=\"left\"   ><b>Hepatitis A</b> : For both killed and live hepatitis-A vaccines 2 doses are recommended</font></td>");
				  out.println("</tr>");
				  out.println("<tr>");
				    out.println("<td align=\"center\"   ><b>2 years</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.plusYears(2).toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>Typhoid 1</b></font></td>");
				    out.println("<td align=\"left\"   ><b>Typhoid</b> : Typhoid revaccination every 3 years, if Vi-polysaccharide vaccine is used.</font></td>");
				  out.println("</tr>");
				  out.println("<tr>");
				    out.println("<td align=\"center\"   ><b>4.5 - 5 years</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.plusMonths(54).toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>DTP B2</br>OPV 3</br>MMR 2</br>Varicella 2</br>Typhoid 2</b></font></td>");
				    out.println("<td align=\"left\"   ><b>MMR</b> : the 2nd dose can be given at anytime 4-8 weeks after the 1st dose.</br><b>Varicella</b> : the 2nd dose can be given at anytime 3 months after the 1st dose.</font></td>");
				  out.println("</tr>");
				  out.println("<tr>");
				    out.println("<td align=\"center\"   ><b>10 - 12 years</b></font></td>");
				    out.println("<td align=\"center\"   >"+getFormattedDate(tikkaDate.plusYears(10).toString())+"</font></td>");
				    out.println("<td align=\"center\"   ><b>Tdap/Td</br>HPV</b></font></td>");
				    out.println("<td align=\"left\"   ><b>Tdap</b> : is preferred to Td followed by Td every 10 years.</br><b>HPV</b> : Only for females, 3 doses at 0, 1-2 (depending on brands) and 6 months.</font></td>");
				  out.println("</tr>");
				out.println("</table>");
				}
		  			%>				
				</div>
				<div class="row">	
				</div> 
	      	</li>
	      
	      	
	      	<li id ="parentZoneTab">
				
				<div class="row">
					<div class="twelve columns">
						<div class="panel callout">
							<h5> Chat with other online parents</h5>
							<p>ipsum.</p>
						</div>
					
					</div>
				</div>
			</li>
	      
	      	
	      	<li id ="liveConsultTab">
				
				<div class="row">
					<%
					String link="";
    				link = YoutubeBroadcastHandler.getLiveStream().trim();
    				if(link.length()<1){
	    				out.print("<h5>No VacciExpert is available Live, but you can chat with other online parents!</h5>");
						out.print("<div class=\"row\">");
							
							out.print("<div class=\"twelve columns\">");
	                                out.print("<textarea style=\"height:315px;\" readonly ></textarea>");
		    				out.print("</div>");
	    				out.print("</div>");
    				}else{
	    				out.print("<h5>You can ask all your queries from our VacciExpert.</h5>");
						out.print("<div class=\"row\">");
							out.print("<div class=\"eight columns\">");
								out.print("<div class=\"flex-video\">");
		      						out.print("<iframe width=\"800\" height=\"315\" src=\""+link+"\" frameborder=\"0\" allowfullscreen></iframe>");
		    					out.print("</div>");
		    				out.print("</div>");
							out.print("<div class=\"four columns\">");
	                                out.print("<textarea style=\"height:315px;\" readonly ></textarea>");
		    				out.print("</div>");
	    				out.print("</div>");
    				}
    				out.print("<div class=\"row\">");	
						out.print("<div class=\"twelve columns\">");
						
	    					out.print("<form>");
	      								out.print("<div class=\"ten columns\">");
	          								out.print("<input type=\"text\" id=\"kutta\">");
	        							out.print("</div>");
	        							out.print("<div class=\"\">");
	          								
                                		out.print("<button class=\"button\">Submit</button>");
	        							out.print("</div>");
							out.print("</form>");
	    				out.print("</div>");	
						out.print("<div id=\"chatArea\" class=\"twelve columns\">");
	    					
	    				out.print("</div>");
    				out.print("</div>");
    				%>	
				</div>
			</li>
	      
	      	
	      	<li id ="homeConsultTab">
				
				
		  		<div class="row">
			  		<dl class="tabs" data-tab>
					  <dd class="active"><a href="#panel2-1">New Appointments</a></dd>
					  <dd><a href="#panel2-2">Appointments History</a></dd>
					</dl>
					<!--
					<div class="tabs-content">
					  <div class="content active" id="panel2-1">
					    <p>First panel content goes here...</p>
					  </div>
					  <div class="content" id="panel2-2">
					    <p>Second panel content goes here...</p>
					  </div>
					</div>
					-->
					<form  class="nice custom" action="appointmentHandler" method="post" onsubmit="return appointmentform(this);")>
					<fieldset>
        					<legend>Add a new Appointment </legend>
								<input type="hidden" id="source" name="source" value="parent" />
								<input type="hidden" id="action" name="action" value="addAppointment" />
								<div class="row">
									<div class="six columns">
        								<!--<label>Hospital name</label>-->
        								<label>Your Pincode</label>
        								<input type="text" id="hospitalName" placeholder = "Your Pincode" name = "hospitalName" />
        								<label for="hospitalName" maxlength="6" class="error" id="hospitalNameError">Please enter valid your Pincode</label>
        							</div>
        						</div>
        						<div class="row" id ="appointmentDate">
        								<label>Appointment date in DD/MM/YYYY format</label>
        							<div class="eight columns">
		        					<div class="four columns ">
		        						<label for="mappointment" class="error" id="mappointmentError">Please Enter correct month</label>
		        						<input type="text" maxlength="2" id="mappointment" placeholder="MM" name="mappointment"/>
		        					</div>
		        					<div class="four columns pull-two">
		        						<label for ="dappointment" class="error" id = "dappointmentError">Please Enter correct Date</label>
		        						<input type="text" maxlength="2" id="dappointment" placeholder="DD" name ="dappointment"/>
		        					</div>
		        					<div class="four columns pull-three">
		        						<label for="yappointment" class="error" id="yappointmentError">Please Enter correct year</label>
		        						<input type="text" maxlength="4" id="yappointment" placeholder="YYYY" name="yappointment"/>
		        					</div>
        							</div>
        				
        						<div class="four columns pull-four">
        							<label class="error" id ="appointmentDateError">Please enter correct appointment date </label>
        						</div>
	        	
        			</div>
        			<br/>
					<input type="hidden" value="<%=registrarEmail%>" name="patientId" />
					<input type="hidden" value="<%=mobile%>" name="patientContact" />
					<input type="hidden" value="<%=name%>" name="patientName" />
        			<input type="submit" class="medium blue radius button" value="Create Appointment" />
        			
					</fieldset>
        		</form>	
				
				Appointment History
					<%
						if(appointmentList==null || appointmentList.size()==0)
							out.println("No history found");
						else{
							out.println("<table><thead><tr><th>S.No.</th><th>Created On</th><th>Appt. Date</th><th>VacciCenter Details</th><th>Status</th><th width=\"150\">Comments</th></tr></thead><tbody>");
							Iterator<AppointmentDao> dd =  appointmentList.iterator();
							int i = 1;
							while(dd.hasNext()){
								currentAppointment = dd.next();
								out.println("<tr><td>"+
									i+"</td><td>"+
									currentAppointment.createdOn+"</td><td>"+
									currentAppointment.appointmentDate+"</td><td>Name : "+
									currentAppointment.doctorName+"<br>Contact : "+
									currentAppointment.doctorContact+"<br>Email : "+
									currentAppointment.doctorId+"</td><td>"+
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
	<h2><%=roleString%> Help</h2>
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
	
	<div id ="appointmentAddSuccess" class="reveal-modal medium">
		<h2>Congrats!</h2>
		<p>Your appointment has been created successfully.</p><p> To check the status, click on Appointment History tab</p>
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
		
		if(status == '104'){
			$('#appointmentAddSuccess').reveal();
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
	  if($('#name').val().length<3 || isNumeric($('#name').val())){
		  $('#nError').show();
		  return false;
	  }
	  
	//check pin number
	var pin = $('#pin').val();
	
	if(pin.length == 6 || pin.length == 0){
	
		if(pin.length == 6 && !isNumeric(pin)){
			$('#pinError').show();
			return false;
		}	
			
	}
	else{
		$('#pinError').show();
		return false;
	}
	  
	  //check email
	  if($('#email').val().length>0 && !isEmail($('#email').val())){
		  $('#eError').show();
		  return false;
	  }	  
	  
	//check mobile number and its optional
	var mobile = $('#mobile').val();
	
	if(mobile.length == 0 || mobile.length == 10 ){
		if(mobile.length == 10 ){
			if(!isNumeric(mobile)){
				$('#mError').show();
				return false;
			}	
			return true;
		}
		return true;
	}
	else{
		$('#mError').show();
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
  	
  	if(!isNumeric(yday) || yday<2001 || yday >2014 || yday.length<4){
  	    $('#dobError').show();
  		return false;
  	}
	return true;
}
  //appointment forms validation
function appointmentform(){
	  $('.error').hide();
  	//check Child's name
  	if($('#hospitalName').val().length<3){
		  $('#hospitalNameError').show();
		  return false;
	  }
  	
  	//check day
  	dappointment = $('#dappointment').val();
  	mappointment = $('#mappointment').val();
  	yappointment = $('#yappointment').val();
  	
  	
  	
  	if(!isNumeric(dappointment) || dappointment<1 || dappointment >31 || dappointment.length<1){
  		$('#appointmentDateError').show();
  		return false;
  	}
  	
  	
  	if(!isNumeric(mappointment) || mappointment<1 || mappointment >12 || mappointment.length <1){
  		$('#appointmentDateError').show();
  		return false;
  	}
  	
  	if(!isNumeric(yappointment) || yappointment<2014 || yappointment >2014 || yappointment.length<4){
  	    $('#appointmentDateError').show();
  		return false;
  	}
	return true;
}
	
	
</script>
  
  

</body>