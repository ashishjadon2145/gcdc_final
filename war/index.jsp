<!doctype html>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
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
	UserService userService = UserServiceFactory.getUserService();
%>

<!--  Upload it to repository  |Got it Ashish -->

<html  lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Vaccinate | Welcome</title>
    <link rel="stylesheet" href="css/foundation.css" />
    <script src="js/modernizr.js"></script>
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
  <body>
  

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
	          	<li  class="">
	          	
	          		<a href="scheduler.jsp"><span data-tooltip class="has-tip tip-right" title="Find the personal vaccination scheduler for your child">Scheduler</span></a>

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



<!-- Slider -->
<div class="large-12 columns">
<div class="large-2 columns"></div>
<div class="large-8 columns push-2">
<ul class="example-orbit" data-orbit>
  <li>
    <img src="img/img11.png"  alt="slide 1" />
    <div class="orbit-caption">
		<strong>2-3 million deaths, every year, are prevented with proper Immunization.</strong>
    </div>
  </li>
  <li>
    <img src="img/img33.png"  alt="slide 2"/>
    <div class="orbit-caption">
		<strong> Still, In 2012 an estimated 22.6 million infants were not reached with routine immunization services. 20% are in India alone</strong>
    </div>
  </li>
  <li>
    <img src="img/img22.png"   alt="slide 3" />
    <div class="orbit-caption">
      <strong>It is ours and your responsibilty to give each child  healthy life.</strong>
    </div>
  </li>
</ul>
</div>
<div class="large-2 columns"></div>
</div>
<!-- Slider ends -->

<!--  About Us Starts. -->

<!-- <div class="row">
	<hr />
</div> -->

<div class="row" id="aboutus">
	<hr />
	<div class="large-12 columns">
		
		<h1>We are here to help you take care of your child</h1>
		<h3 class="subheader">To get going please checkout the following services</h3>
		
		<hr/>
				
		<div class="large-4 columns">
			<h3>
			<a href="scheduler.jsp">
				Get Vaccination<strong> Schedule</strong>
			</a>
			</h3>
			
			<p class="text-justify">
				Get your child's personalised vaccination schedule by just entering the date of birth. 
				Download the schedule and add reminders to your google calendar. 
			
			</p>
			<a href="scheduler.jsp" class="button small">Scheduler  &#8594</a>
		</div>
		
		<div class="large-4 columns">
			<h3>
			<a href="locator.jsp">
				Find Nearest <strong>Vaccination Center</strong>
			</a>
			</h3>
			<p class="text-justify">
				Use the locator to find the nearest vaccination center to you. 
				On the vaccination date make your child immune with correct vaccination.
			</p>
			<a href="locator.jsp"class="button small">Locator  &#8594</a>
		</div>
		
		
		
		<div class="large-4 columns">
			<h3>
			<a href="<%=parentLoginUrl%>">
				Never forget by <strong>Registering</strong>
			</a>
			</h3>
			<p class="text-justify">
				With on time emails, Phone calls to remind you.
				Managing multiple children and free consultation with our in house doctors. 
				Never worry about the health of your child. 
			
			</p>
			<a href="<%=parentLoginUrl%>" class="button small">Sign in &#8594</a>
			
		</div>
	
	
	</div>
	
	
</div>


<!-- Connect With Us page -->
<div class="row" id="getInvolved">
<hr />
	<div class="large-12 columns">
	
		<h1>Connect with us...</h1>
		<h3 class="subheader">Let's walk hand in hand to make this world a better place</h3>
		<hr />	
		<!-- address and phone number -->
		<div class="large-12 columns">
			<h3>Doctors, Hospitals and Vaccination Centers</h3>
			<ul class="vcard">
				<li class="street-address">If you are a Doctor, Hospital or Vaccination Center, then you can </li>
				<li class="locality">Step1 : <a href="<%=hospitalLoginUrl%>">Register</a> on our website and update your basic information and services you provide.</li>
				<li class="locality">Step2 : Your details will be verified by Vaccinate Officials.</li>
				<li class="locality">Step3 : Once verified, Your information will be available on our website and parents can search your center and contact you for vaccination and other consultation as well.</li>
				<li class="locality">Step4 : <a href="<%=hospitalLoginUrl%>">Login</a> to see your dashboard (home vaccination requests). And Provide service to the parents.</li>
			</ul>
			
			<h3>Volunteer</h3>
			<ul class="vcard">
				<li class="street-address">If you have a cellphone, knows how to read and speak english and willing to help the cause of Vaccinate, then you can </li>
				<li class="locality">Step1 : <a href="<%=volunteerLoginUrl%>">Register</a> on our website and update your information.</li>
				<li class="locality">Step2 : Your details will be verified by Vaccinate Officials</li>
				<li class="locality">Step3 : Once verified, you can <a href="<%=volunteerLoginUrl%>">Login</a> to see your dashboard (List of parent to be called for vaccination reminder) and call parents to remind them about he due vaccinations for their children.</li>
			</ul>
			
			<h3>Job Opportunity</h3>
			<ul class="vcard">
				<li class="street-address">If you are a medical professional and know how to give vaccines, then you can </li>
				<li class="locality">Step1 : <a href="<%=freelancerLoginUrl%>">Register</a> on our website to upload your documents and information.</li>
				<li class="locality">Step2 : Your interview will be taken by Vaccinate Officials</li>
				<li class="locality">Step3 : Once verified, parents can search you and book appointment for home vaccination.</li>
				<li class="locality">Step4 : <a href="<%=freelancerLoginUrl%>">Login</a> to see your dashboard (home vaccination requests). And Provide service to the parents.</li>
			</ul>
		
		</div>
	</div>


</div>

<!-- contact us page -->
<!-- Connect With Us page -->
<div class="row" id="feedback">
	<hr />
	<div class="large-12 columns">
	
		<h1>Contact Us . Anytime!</h1>
		<hr />	
		<!-- address and phone number -->
		<div class="large-4 columns">
			<h3>We are present at</h3>
			<ul class="vcard">
				<li class="fn">Address</li>
				<li class="street-address">House No. 1/4614, St. No. 2 </li>
				<li class="locality">Ramnagar Extn., Shahdara</li>
				<li class="state">New Delhi, India</li>
				<li class="state">Pincode : 110032</li>
				<li class="fn">Email</li>
				<li class="email"><a href="#">vaccinateindia@gmail.com</a></li>
				<li class="fn">Contact</li>
				<li class="email"> +91 - 9555505352</li>
				<li class="email"> +91 - 9013955267</li>
				<li class="email"> +91 - 9021813612</li>
				
			</ul>
		
		</div>
		
		
		<!-- feedback form -->
		<div class="large-8 columns">
			<h3>For any <strong>Feedback</strong>. Please fill the following form</h3>
			<form data-abide>
				<fieldset>
				<legend>Feedback form</legend>
				<div class="name-field">
					<label>Your Name <small>Required</small></label>
					<input type="text" required pattern="[a-zA-Z]" />
					<small class="error"> Name is required and must be a string</small>
				</div>
				
				<div class="email-field">
					<label>Your Email Address <small>Required</small></label>
					<input type="email" required>
					<small class="error">An email address is required</small>				
				</div>
				
				<div class="feddback-field">
					<label>Your Questions/Thoughts/Comments</label>
					<textarea required></textarea>
					<small class="error">Your feedback is important us.</small>
				</div>
				
				<button type="submit">Submit</button>				
				</fieldset>
			</form>
			
		</div>
	
	
	</div>

</div>

<!-- contact us page -->



<!-- Footer start -->
  
  <footer class="row">
    <div class="large-12 columns">
      <hr />
      <div class="row">
        <div class="large-6 columns">
          <p>© Copyright no one at all. Go to town.</p>
        </div>
        <div class="large-6 columns">
          <ul class="inline-list right">
            <li><a href="index.jsp#aboutus">About Vaccinate</a></li>
            <li><a href="index.jsp#feedback">Feedback</a></li>
            <li><a href="faqs.html">FAQs</a></li>
            <li><a href="index.jsp#getInvolved">Volunteer</a></li>
          </ul>
        </div>
      </div>
    </div> 
  </footer>
<!--  Footer ends -->



   
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
    
    <div id="errModal" class="reveal-modal small" data-reveal>
    	<div id="errTxt" ></div>
 	   <a class="close-reveal-modal">&#215;</a>    
    </div>

<!-- Modals -->
        <script src="js/jquery.js"></script>
          <script src="js/foundation.min.js"></script>    
    <script src="js/foundation.topbar.js"></script>
    <script src="js/foundation.orbit.js"></script>
    <script src="js/foundation.abide.js"></script>
    <script src="js/foundation.reveal.js"></script>
    <script>
      $(document).foundation();
     
      $(document).ready(function(){
      function getQueryVariable(variable)
      {
             var query = window.location.search.substring(1);
             var vars = query.split("&");
             for (var i=0;i<vars.length;i++) {
                     var pair = vars[i].split("=");
                     if(pair[0] == variable){
                    	 return pair[1];
                     }
             }
             return(false);
      }
      
      var status = getQueryVariable("status");
      
      var errors= [ 'You are not authorized to access this section.</br></br>Do Not try this again. </br></br><b>It might be dangerous!</b>',
                    'You are not authorized to access this section.</br></br>Please choose correct role and try again!',
                    'You are not logged in.</br></br>Please try logging in again!',
                    'You are not logged in! try again!',
                    '<a href="<%= userService.createLogoutURL("/index.jsp")%>" >Log out</a> of your currently logged in google account and try again.',
                    '<h3>Hey!</h3> Don\'t try to fool us </h3>'
                    ];
      
      if(status){
    	  $('#errTxt').html(errors[status-1]);
    	  $('#errModal').foundation('reveal','open');
      }
      
      });
    </script>
  </body>
</html>
