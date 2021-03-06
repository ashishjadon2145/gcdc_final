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
<%@ page import="com.osahub.hcs.vaccinate.bean.CallReminderBackingBean" %> 
<%@ page import="com.osahub.hcs.vaccinate.dao.user.CallRecordDao" %> 
<%@ page import="java.util.Iterator" %> 

<%@ page import="com.osahub.hcs.vaccinate.controller.admin.YoutubeBroadcastHandler" %>  


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
	//for dashboard functionality
	List<CallRecordDao> callRecordList = null;
	CallReminderBackingBean callReminderBean = null;
	CallRecordDao currentCallRecord;
	
	
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
	if(session.getAttribute("helplineID")!=null)
		userId = session.getAttribute("helplineID").toString();
	else
		response.sendRedirect("/index.jsp?status=3");
	
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
			username = p1.userName;
			
			
			//call reminders
				callReminderBean = new CallReminderBackingBean();
				callRecordList = callReminderBean.getAllCallsToBeMade();
			
			childCount = p1.childCount;
			registrarEmail = p1.email;
			if(childCount > 0){
				childList = new ArrayList<Child>();
				childList = com.osahub.hcs.vaccinate.controller.register.UpdateProfile.getChildListFromParentEmail(registrarEmail);
				childCount = childList.size();
			}
			
			role = p1.role;
			roleString = DropdownUtil.GetRoleStringFromInt(role);
		
		}
	} catch(Exception e){
		e.printStackTrace();
		response.sendRedirect("/index.jsp?status=021"); //An error occured! please login again	
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

	<title>Vaccinate : Helpline Home </title>
	<script language="javascript" src="user/javascripts/callList.js"></script>

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
			<dd ><a href="#main-content">Dashboard</a></dd>
			<dd><a href="#liveConsult">Live Consult & Chat</a></dd>
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
        			<input type="hidden" id="action" name="action" value="updateHelplineDetails" />
        			<input type="hidden" id="action" name="source" value="helpline" />
        			
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
        			<!--
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
        			<input type="text"  id="pin" value="<%=String.format("%06d",p1.pin)%>" placeholder="PIN (optional)" name = "pin"/>
        			<label for="pin" class="error" id="pinError">Please enter a valid pin number of 6 characters</label>
        						</div>
        					</div>	
        			</fieldset>
        			

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
					if(callRecordList==null || callRecordList.size()==0)
						out.println("No New Appointment found");
					else{
						out.println("<form name =\"approveUser\" action=\"dailyCallHandler\" method=\"post\" >");
						out.println("<input type=\"hidden\" id=\"source\" name=\"source\" value=\"helpline\" />");
						out.println("<input type=\"hidden\" id=\"action\" name=\"action\" value=\"callMade\" />");
						out.println("<input type=\"hidden\" name=\"approveUserList\" id=\"approveUserList\">");
						out.println("<input type=\"hidden\" name=\"newApptActionList\" id=\"newApptActionList\">");
						out.println("<input type=\"hidden\" name=\"newApptCommentList\" id=\"newApptCommentList\">");

						
								
						out.println("<table><thead><tr><th></th><th>Created On</th><th>Description</th><th>Action</th><th width=\"150\">Comments</th></tr></thead><tbody>");
						Iterator<CallRecordDao> dd =  callRecordList.iterator();
						int i = 1;
						while(dd.hasNext()){
							currentCallRecord = dd.next();
							if(currentCallRecord.status == 1)
							out.println("<tr><td><input type=\"checkbox\" name=\"approveMob\" id=\"approveMob\" value=\""+
								currentCallRecord.callId+"\" /></td><td>"+
								currentCallRecord.createdOn+"</td><td>"+
								currentCallRecord.description+"</td><td><select id=\"newApptAction\" name=\"newApptAction\"><option value=\"2\">Not Answered</option><option value=\"3\">Not Reachable</option><option value=\"4\">Wrong Number</option><option value=\"5\">Rejected</option><option value=\"6\">Closed</option></select></td><td><textarea id=\"newApptComment\" name=\"newApptComment\" ></textarea></td></tr>");
								i++;
						}
						out.println("</tbody></table>");
						out.println("<input type=\"submit\" onclick=\"return approve1()\" class=\"medium blue radius button\" value=\"Submit\" />");
						out.println("</form>");
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
	    				out.print("<h5>Answer the queries of online parents!</h5>");
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
	
	<div id ="successCallMadeSubmit" class="reveal-modal medium">
		<h2>Success!</h2>
		<p>You have successfully updated the callee list.</p>
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
		
		//success  while updating Accepted Appointments  
		if(status == '107'){
			$('#successCallMadeSubmit').reveal();
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
	  if($('#name').val().length<3 || isNumeric($('#name').val())){
		  $('#nError').show();
		  return false;
	  }
	  
	
	  
	  //check email
	  if($('#email').val().length>0 && !isEmail($('#email').val())){
		  $('#eError').show();
		  return false;
	  }	  
	  
	//check mobile number and its optional
	var mobile = $('#mobile').val();
	
	if(mobile.length != 10 || !isNumeric(mobile) ){
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
  	
  	if(!isNumeric(yday) || yday<2001 || yday >2013 || yday.length<4){
  	    $('#dobError').show();
  		return false;
  	}
	return true;
}
	
	
</script>
  
  

</body>