 <%@ page import="java.util.Date" %>
    <%@ page import="org.joda.time.*" %>
    <%@ page import="com.osahub.hcs.vaccinate.util.DropdownUtil" %>
    
    <%

//try{
//String d = DropdownUtil.GetCategoryStringFromInt(1);
	String childName = request.getParameter("childName");
	String dateOfBirth = request.getParameter("dateOfBirth");
	//if( childName == null || dateOfBirth == null)
		//response.sendRedirect("scheduler.jsp");
	
//}catch(Exception r){
		//response.sendRedirect("scheduler.jsp");
//}

LocalDate tikkaDate = new LocalDate(dateOfBirth.substring(6,10)+"-"+dateOfBirth.substring(0,2)+"-"+dateOfBirth.substring(3,5));

%>



<%!
public String getFormattedDate(String tikkaDate){
	String formattedDate="";
	formattedDate = tikkaDate.substring(8, 10)+"/"+tikkaDate.substring(5, 7)+"/"+tikkaDate.substring(0, 4);
	return  formattedDate;
} 
public String getBirthDate(String tikkaDate){
	String formattedDate="";
	formattedDate = tikkaDate.substring(3, 5)+"/"+tikkaDate.substring(0, 2)+"/"+tikkaDate.substring(6, 10);
	return  formattedDate;
} 

%>
    <!DOCTYPE html>
<html lang="en">
	<head>
	<style>
	table,td
	{border:2px solid red;}
	</style>
		<meta charset="utf-8">
		<title>GCDC 2013 : Vaccinate|Scheduler</title>
		<link rel="icon" href="images/favicon.ico">
		<link rel="shortcut icon" href="images/favicon.ico" />
		<link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="css/camera.css">
		<link rel="stylesheet" href="css/form.css">
		<script src="js/jquery.js"></script>
		<script src="js/jquery-migrate-1.1.1.js"></script>
		<script src="js/superfish.js"></script>
		<script src="js/forms.js"></script>
		<script src="js/jquery.ui.totop.js"></script>
		<script src="js/jquery.equalheights.js"></script>
		<script src="js/jquery.easing.1.3.js"></script>
		<script src="js/jquery.ui.totop.js"></script>
		<script src="js/tms-0.4.1.js"></script>
		<script>
			$(document).ready(function(){
				$('.slider_wrapper')._TMS({
					show:0,
					pauseOnHover:false,
					prevBu:'.prev',
					nextBu:'.next',
					playBu:false,
					duration:800,
					preset:'fade',
					pagination:true,//'.pagination',true,'<ul></ul>'
					pagNums:false,
					slideshow:8000,
					numStatus:false,
					banners: 'fade',
					waitBannerAnimation:false,
					progressBar:false
				});
			});
			$(document).ready(function(){
				!function(){
			var map=[]
			 ,names=[]
			 ,win=$(window)
			 ,header=$('header')
			 ,currClass
			$('.content').each(function(n){
			 map[n]=this.offsetTop
			 names[n]=$(this).attr('id')
			})
			win
			 .on('scroll',function(){
				var i=0
				while(map[i++]<=win.scrollTop());
				if(currClass!==names[i-2])
				currClass=names[i-2]
				header.removeAttr("class").addClass(names[i-2])
			 })
			}(); });
					function goToByScroll(id){
				$('html,body').animate({scrollTop: $("#"+id).offset().top},'slow');
				}
				$(document).ready(function(){
					$().UItoTop({ easingType: 'easeOutQuart' });
				});
		</script>
		<!--[if lt IE 8]>
			<div style=' clear: both; text-align:center; position: relative;'>
				<a href="http://windows.microsoft.com/en-US/internet-explorer/products/ie/home?ocid=ie6_countdown_bannercode">
					<img src="http://storage.ie6countdown.com/assets/100/images/banners/warning_bar_0000_us.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." />
				</a>
			</div>
		<![endif]-->
		<!--[if lt IE 9]>
			<script src="js/html5shiv.js"></script>
			<link rel="stylesheet" media="screen" href="css/ie.css">
		<![endif]-->
		
		<!-- for calender-->
		<script src="script/jquery-1.9.1.js"></script>
<script src="script/jquery-ui.js"></script>
<script src="script/style1.js"></script>
<script  >
$(function() {
$( "#datepicker" ).datepicker();
});


</script>
<link rel="stylesheet" href="/css/calander-style.css" />
	</head>
	<body class="">
<!--==============================header=================================-->
		<header class="page1">
			<div class="container_12">
				<div class="grid_12">
					<h1><a href="index.jsp" ><img src="images/logo.png" alt="Gerald Harris attorney at law"></a></h1>
					<div class="menu_block">
						<nav class="">
							<ul class="sf-menu">
								<li class=""><a href="/scheduler">Back </a> <strong class="hover"></strong></li>
								<li class="current men"><a onClick="goToByScroll('page5'); return false;" href="#">Customized Scheduler</a> <strong class="hover"></strong></li>
							</ul>
						</nav>
						<div class="clear"></div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</header>
<!--=======content================================-->
                <div id="page1" class="content schedule">
                        <div class="ic"></div>
                        <div class="container_12"><div class="grid_12">
                                        <div class="slogan">
                                                <h3 class="slogan-h3">Customized Vaccination Schedule</h3>
                                                <div class="text1">
                                                        Here is the vaccination schedule for "<b><%=childName.toUpperCase() %></b> "
                                                </div>
                                        </div>
                                </div>
                                <div class="clear"></div>
                                <div class="map">
                                       
                                        <div class="grid_12">
                                       
                                       
<form id="form111" method="post" action="downloadSchedule">

<input type="hidden" name="childName" id="childName"   value="<%=childName %>">
<input type="hidden" name="dateOfBirth" id="dateOfBirth"    value="<%=dateOfBirth %>">


						<div class="btns">
							<a  class="link1" onclick="document.getElementById('form111').submit();">Click Here to Download</a>
						</div>
</form>
 
        <div id = "chart-schedule">
                                        <table class="pretty-table" background="\images\logo2.png" width="900"  align="center">
  <thead>
        <tr>
    <th scope="col" colspan="2" align="center"   >Child Name</th>
    <th scope="col" colspan="2" align="center"   ><%out.println(childName);%></th>
    </tr>
  </thead>
 
  <thead>
  <tr>
    <th colspan="2" align="center"   >Date of Birth</th>
    <th colspan="2" align="center"   ><%out.println(getBirthDate(dateOfBirth).substring(3,5)+"/"+getBirthDate(dateOfBirth).substring(0,2)+"/"+getBirthDate(dateOfBirth).substring(6,10)); %></th>
  </tr>
  </thead>
  <td></td><td></td><td></td><td></td>
  <thead>
  <tr>
    <th width="143" align="center"   ><font face="arial" size="3" >Age</th>
    <th width="143" align="center"   ><font face="arial" size="3" >DUE DATE</th>
    <th width="143" align="center"   ><font face="arial" size="3" >VACCINE</th>
    <th width="143" align="center"   ><font face="arial" size="3" >Comments</th>
    </tr>
  </thead>
 
  <tr>
    <td align="center"   ><font face="arial" size="3"   ><b>Birth</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.toString())); %></font></td>
    <td align="center"   ><b>B.C.G.</br>Hep-B 1</b></font></td>
    <td align="center"   ></font></td>
  </tr>
  <tr>
    <td align="center"   ><b>6 weeks</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.plusDays(42).toString())); %></font></td>
    <td align="center"   ><b>DTP 1</br>IPV 1</br>Hep-B 2</br>Hib 1</br>Rotavirus 1</br>PCV 1</b></font></td>
    <td align="left"   ><b>Polio</b> : Use IPV. But may be replaced with OPV if former is unaffordable/unavailable</br><b>Rotavirus</b> : 2 doses of RV-1 and 3 doses of RV-5</font></td>
  </tr>
  <tr>
    <td align="center"   ><b>10 weeks</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.plusDays(70).toString())); %></font></td>
    <td align="center"   ><b>DTP 2</br>IPV 2</br>Hib 2</br>Rotavirus 2</br>PCV 2</b></font></td>
    <td align="center"   ></font></td>
  </tr>
  <tr>
    <td align="center"   ><b>14 weeks</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.plusDays(98).toString())); %></font></td>
    <td align="center"   ><b>DTP 3</br>IPV 3</br>Hib 3</br>Rotavirus 3</br>PCV 3</b></font></td>
    <td align="left"   ><b>Rotavirus</b> : Only 2 doses of RV1 are recommended at present.</font></td>
  </tr>
  <tr>
    <td align="center"   ><b>6 months</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.plusMonths(6).toString())); %></font></td>
    <td align="center"   ><b>OPV 1 </br>Hep-B 3</b></font></td>
    <td align="left"   ><b>Hepatitis-B</b> : The final (third or fourth) dose in the HepB vaccine series should be administered no earlier than age 24 weeks and at least 16 weeks after the first dose.  </font></td>
  </tr>
  <tr>
    <td align="center"   ><b>9 months</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.plusMonths(9).toString())); %></font></td>
    <td align="center"   ><b>OPV 2</br>Measles</b></font></td>
    <td align="left"   ><b></b>  </font></td>
  </tr>
  <tr>
    <td align="center"   ><b>12 months</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.plusMonths(12).toString())); %></font></td>
    <td align="center"   ><b>Hep-A 1</b></font></td>
    <td align="left"   ><b>Hepatitis A</b> : For both killed and live hepatitis-A vaccines, 2 doses are recommended</font></td>
  </tr>
  <tr>
    <td align="center"   ><b>15 months</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.plusMonths(15).toString())); %></font></td>
    <td align="center"   ><b>MMR 1</br>Varicella 1</br>PCV booster</b></font></td>
    <td align="left"   ><b>Varicella</b> : The risk of breakthrough varicella is lower if given 15 months onwards.</font></td>
  </tr>
  <tr>
    <td align="center"   ><b>16-18 months</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.plusMonths(16).toString())); %></font></td>
    <td align="center"   ><b>DTP B1</br>IPV B1</br>Hib B1</b></font></td>
    <td align="left"   >The first booster (4thth dose) may be administered as early as age 12 months, provided at least 6 months have elapsed since the third dose.</font></td>
  </tr>
  <tr>
    <td align="center"   ><b>18 months</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.plusMonths(18).toString())); %></font></td>
    <td align="center"   ><b>Hep-A 2</b></font></td>
    <td align="left"   ><b>Hepatitis A</b> : For both killed and live hepatitis-A vaccines 2 doses are recommended</font></td>
  </tr>
  <tr>
    <td align="center"   ><b>2 years</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.plusYears(2).toString())); %></font></td>
    <td align="center"   ><b>Typhoid 1</b></font></td>
    <td align="left"   ><b>Typhoid</b> : Typhoid revaccination every 3 years, if Vi-polysaccharide vaccine is used.</font></td>
  </tr>
  <tr>
    <td align="center"   ><b>4.5 - 5 years</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.plusMonths(54).toString())); %></font></td>
    <td align="center"   ><b>DTP B2</br>OPV 3</br>MMR 2</br>Varicella 2</br>Typhoid 2</b></font></td>
    <td align="left"   ><b>MMR</b> : the 2nd dose can be given at anytime 4-8 weeks after the 1st dose.</br><b>Varicella</b> : the 2nd dose can be given at anytime 3 months after the 1st dose.</font></td>
  </tr>
  <tr>
    <td align="center"   ><b>10 - 12 years</b></font></td>
    <td align="center"   ><%out.println(getFormattedDate(tikkaDate.plusYears(10).toString())); %></font></td>
    <td align="center"   ><b>Tdap/Td</br>HPV</b></font></td>
    <td align="left"   ><b>Tdap</b> : is preferred to Td followed by Td every 10 years.</br><b>HPV</b> : Only for females, 3 doses at 0, 1-2 (depending on brands) and 6 months.</font></td>
  </tr>
</table>


                    </div>
				</div>
                
	      	</li>
	      	
   
	  </ul>
	  
	  </div>
	  </div>
 
						
					</div>
					
			
				</div>
					</br>	</br>
			</div>
		</div>
		
		
<!--==============================footer=================================-->
		<footer>
			<div class="container_12">
				<div class="grid_12">
					<div class="copy">
						<a onClick="goToByScroll('page1'); return false;" href="#"><img src="images/footer_logo.png" alt=""></a>  &copy; 2013 | Privacy Policy <br> <br>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</footer>
	</body>
</html>
