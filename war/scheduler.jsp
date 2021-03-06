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
<link href="http://netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.min.css" rel="stylesheet">

<link rel="stylesheet" href="css/foundation-datepicker.css" date-date-format="dd-mm-yyyy" />
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

<script src="https://apis.google.com/js/platform.js">
      {parsetags: 'explicit'}
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
	<!-- content of scheduler -->

	<div class="row">
		<div class="large-12 columns">
			<h2>
				Personalized vaccination schedule for your child 
			</h2>
		</div>

		
		

		<!--  scheduler locator looks -->
		<div class="large-12 columns">
			<!-- - right side on larger screens so the default scheduler -->
			<div class="large-9 push-3 columns">
				<h4>Vaccination Scheduler  <small> The proper immunization schedule </small></h4>
				<hr />
				<br />
					<span class="schBtns">
					<a href="#" class="button tiny schBtns" id="pdf">Download</a> 
					<a href="#" class="button tiny schBtns " id="calBtn">Add to	Calendar </a>
					<div  id="gdriveBtn" >
						<div class="g-savetodrive"
						   data-src="/getPDF"
                           data-filename="My Statement.pdf"
   						   data-sitename="My Company Name">
   						   </div>
					</div>
                     <hr />
					</span>

					
					<div id="chart">
						<table>
							<thead>
								<tr>
								<td> Age </td>
								<td width="100%" class="text-center"> Vaccine</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td> Birth </td>
									<td><strong>B.C.G.<br /> Hep-B 1	</strong>								 </td>
								</tr>
								
																<tr>
									<td>  6 Weeks </td>
									<td> <strong>DTP 1
<br />IPV 1
<br />Hep-B 2
<br />Hib 1
<br />Rotavirus 1
<br />PCV 1</strong></td>
								</tr>
																<tr>
									<td> 10 Weeks </td>
									<td> <strong>DTP 2
<br />IPV 2
<br />Hib 2
<br />Rotavirus 2
<br />PCV 2 </strong></td>
								</tr>
																<tr>
									<td> 14 Weeks </td>
									<td><strong>DTP 3
<br />IPV 3
<br />Hib 3
<br />Rotavirus 3
<br />PCV 3</strong> </td>
								</tr>
																<tr>
									<td> 6 Months</td>
									<td> <strong>OPV 1 
<br />Hep-B 3</strong></td>
								</tr>
																<tr>
									<td> 9 Months </td>
									<td><strong>OPV 2
<br />Measles</strong> </td>
								</tr>
																<tr>
									<td>  12 Months</td>
									<td> <strong>Hep-A 1</strong></td>
								</tr>
																<tr>
									<td> 15 Months</td>
									<td> <strong>MMR 1
<br />Varicella 1
<br />PCV booster</strong> </td>
								</tr>
																<tr>
									<td> 16-18 Months</td>
									<td> <strong>
									DTP B1
<br />IPV B1
<br />Hib B1
									</strong></td>
								</tr>
									
																<tr>
									<td> 18 Months</td>
									<td> <strong>Hep-A 2</strong></td>
								</tr>
								
															<tr>
									<td> 2 Years</td>
									<td><strong>Typhoid 1</strong> </td>
								</tr>
								
															<tr>
									<td> 4.5 - 5 Years</td>
									<td> <strong>DTP B2
<br />									
<br />OPV 3
<br />MMR 2
<br />Varicella 2
<br />Typhoid 2</strong> </td>
								</tr>
															<tr>
									<td> 10-12 Years</td>
									<td><strong>Tdap/Td
									<br />
HPV</strong> </td>
								</tr>
								
							</tbody>
						</table>
					</div>
					
			</div>

			<!-- Nav Sidebar -->
			<!-- This is source ordered to be pulled to the left on larger screens -->
			<div class="large-3 pull-9 columns">
				<h4>Your Child's Detail</h4>
				<hr />
				
				<ul class="side-nav">
					
					<li>
						<div class="name-field">
						<label></label>
						<input type="text" name="cName" id="cName" placeholder="Your Child's Name" required pattern="[a-zA-Z]+">
						<small class="error" id="nameError">Name must be alphabets</small>		
						</div>
						
					</li>
					<li >
						<div class="dob-field">
						<label>	</label>
						<input type="text" placeholder="Date of Birth" id="dob" data-date-format="dd-mm-yyyy"  readonly="true" required >
						<small class="error" id="dobError">Please select a date</small>
						
						</div>
					</li>
					<li>
						
					</li>
				
				</ul>
				<a href="#" id="generate" class="tiny button" style="width:100%;" >View Schedule</a>
				</form>
				
			</div>

		</div>


	<!-- 	<div class="large-12 columns">
			<div class="large-2 columns">
				<input type="text" placeholder="Child's Name" id="childName" />
			</div>
			<div class="large-2 columns ">
				<input type="text" placeholder="Date of Birth" id="datepicker" data-date-format="dd-mm-yyyy" readonly>
			</div>
			<div class="large-2 columns">
				<a href="#" class="button radius tiny" id="generate">View
					Schedule</a>
			</div> 

			<div class="large-6 columns push-1">

			</div>
		</div> -->

		<hr />

		<div class="large-12 columns" id="chart"></div>

	</div>

	<!-- content ends -->
	<!-- Footer-->

	<footer class="row">
		<div class="large-12 columns">
			<hr />
			<div class="row">
				<div class="large-6 columns">
					<p>Copyright no one at all. Go to town.</p>
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
	<script src="js/foundation-datepicker.js"></script>
	<script src="js/foundation.reveal.js"></script>
	<script src="js/foundation.abide.js"></script>
	
	<script src="js/date.js"></script>
	<!-- <script src="js/jspdf.min.js"></script>
	<script src="js/jspdf.plugin.from_html.js"></script>
	<script src="js/jspdf.plugin.cell.js"></script> -->
	<!-- <script src="js/drive.js"></script> -->
	<script gapi_processed="true" type="text/javascript" src="https://apis.google.com/js/client.js"></script>
	<script src="js/gcal.js"></script>


	<script>
	   $('.schBtns').hide();
	   	$('.error').hide();
	     
    	$(document).foundation();
    	
/*     	function tableToJson(table) { 
    		var data = []; // first row needs to be headers var headers = [];
    		var headers=[];
    		for (var i=0; i<table.rows[0].cells.length; i++) {
    		 headers[i] = table.rows[0].cells[i].innerHTML.toLowerCase().replace(/ /gi,''); 
    		} 
    		// go through cells 
    		for (var i=1; i<table.rows.length; i++) { 
    		var tableRow = table.rows[i]; var rowData = {}; 
    		for (var j=0; j<tableRow.cells.length; j++) { 
    			var dat1 = tableRow.cells[j].innerHTML.replace(/<strong>/gi,'');
    			var dat2 = dat1.replace(/<\/strong>/gi,'');
    			rowData[ headers[j] ] = dat2 
    		} data.push(rowData); 
    		} 
    		return data; 
    		} */
    	
      function showTable(schedule){
    	  var startContent = "<div class='large-3 columns'><strong> Child Name: </div><div class='large-3 columns pull-1' style='text-transform:uppercase'>"+ $('#cName').val() + "</strong> </div> <div class='large-3 columns'> <strong>Date of Birth : </div><div class='large-3 columns pull-1'>" + $('#dob').val() + "</strong></div> <br/> <hr />"; 
    	  
    	  var tableContent =  startContent+ "<table id='schtable'> <thead> <tr> <th> Age </th> <th width =\"100\"> Due Date </th> <th width=\"170\"> Vaccine </th> <th> Comments </th> </tr> </thead> <tbody> ";
    	  
    	  for(var i = 0 ; i <schedule.length ; i++){
    		  tableContent += "<tr> <td>"
    		  tableContent += schedule[i].age + "</td><td>";
    		  tableContent += schedule[i].date + "</td><td>";
    		  
    		  for(var j = 1 ; j<= schedule[i].vaccination.length ; j++){
    			  tableContent += "<strong>"+ j +". "+ schedule[i].vaccination[j-1]+"</strong> <br/>"
    		  }    		  
    		  
    		  tableContent += "</td><td>";
    		  tableContent += schedule[i].comments;    		  
    		  tableContent += "</td></tr>"
    		  
    	  }    	  
    	  tableContent += "</tbody> </table>";
    	  
    	  $('#chart').html(tableContent);
    	  
      }
    
      
      //$('#datepicker').click(function(){
    	  
    	  // implementation of disabled form fields
    var nowTemp = new Date();
    var now = new Date(nowTemp.getFullYear()-10, nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
    var now1 = new Date(nowTemp.getFullYear(), nowTemp.getMonth()+1, nowTemp.getDate(), 0, 0, 0, 0);
 
    var checkin = $('#dob').fdatepicker({
        onRender: function (date) {
        	if(date.valueOf()   <  now.valueOf())
        		return 'disabled';
        	else if(date.valueOf() > now1.valueOf() )
        		return 'disabled';
        	else 
        		return '';
        }
    }).on('changeDate', function (ev) {
        return;
    }).data('datepicker');

    	 $('#dob').fdatepicker();  
      
      function validateForm(){
    	  $('.error').hide();
    	  var name = $('#cName').val().trim();
    	  if(!name.match(/^[a-zA-Z]+$/) && name !="")
    	  {  	$('#nameError').show(); return false; }
    	  var dob = $('#dob').val().trim();
    	  if(dob =="" ){
    		  $('#dobError').show(); return false;
    	  }
    		 
    	  return true;  
    	  
    	  
      }
      
      
      $('#generate').click(function(){
    	  if(validateForm()){
    	  var dob = $('#dob').val();
    	  var schedule = getPersonalVaccinationSchedule(dob);
    	  showTable(schedule);
    	  $('.schBtns').show();
    	  //$('#gdriveBtn').innerHTML = '<div class="g-save2drive" data-src="getPDF?cname=' +$('#cName').val+'&dob="'+$('#dob').val()+'" data-filename="Vaccinate_'+$('#cName').val() + '" data-sitename="Vaccinate"></div>' ;
    	  gapi.savetodrive.render('gdriveBtn',{
    		  'src' : "/getPDF?cName="+$('#cName').val()+"&dob="+$('#dob').val(),
    		  'filename' : 'Vaccinate_'+$('#cName').val(),
    	  	  'sitename' : 'Vaccinate India'
    	  });
      }
    	  
      });
      
      $('#pdf').click(function(){
    	  var link = "/getPDF?cName="+$('#cName').val()+"&dob="+$('#dob').val();
    	  $('a#pdf').attr({target : '_blank',
    			href :link  
    	  });
    	  
      });
      


    	 
    </script>
    
</body>
</html>
