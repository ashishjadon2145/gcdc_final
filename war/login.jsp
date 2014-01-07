<!DOCTYPE html>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>GCDC 2013 : Vaccinate|Register</title>
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
	</head>
	<body class="">
<!--==============================header=================================-->
		<header class="page1">
			<div class="container_12">
				<div class="grid_12">
					<h1><a href="#" onClick="goToByScroll('page1'); return false;"><img src="images/logo.png" alt="Gerald Harris attorney at law"></a></h1>
					<div class="menu_block">
						<nav class="">
							<ul class="sf-menu">
								<li class=""><a href="/index.jsp">Home </a> <strong class="hover"></strong></li>
								<li class="current men"><a onClick="goToByScroll('page5'); return false;" href="#">Login</a> <strong class="hover"></strong></li>
							</ul>
						</nav>
						<div class="clear"></div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</header>
<!--=======content================================-->
		<div id="page1" class="content">
			<div class="ic"></div>
			<div class="container_12"><div class="grid_12">
					<div class="slogan">
						<h3>Register</h3>
						<div class="text1">
							Allows you to login and access your dashboard
						</div>
					</div>
				</div>
				<div class="clear"></div>
				<div class="map">
					<div class="grid_4">
						<div class="text1">Login straightway!</div>
						
						<div class="btns">
						<a href="<%=UserServiceFactory.getUserService().createLoginURL("/login?role=1")%>"  class="link1">Parent Sign in with Google</a>
						</div>
						<div class="btns">
						<a href="<%=UserServiceFactory.getUserService().createLoginURL("/login?role=2")%>"  class="link1">Hospital Sign in with Google</a>
						</div>
						<div class="btns">
						<a href="<%=UserServiceFactory.getUserService().createLoginURL("/login?role=3")%>"  class="link1">Helpline Sign in with Google</a>
						</div>
						<div class="btns">
						<a href="<%=UserServiceFactory.getUserService().createLoginURL("/login?role=4")%>"  class="link1">Admin Sign in with Google</a>
						</div>
					</div>
					
					<div class="grid_5">
						<div class="text1">Features</div>
						<div class="text2">- No Registration required</div><div class="clear"></div>
						<div class="text2">- Secure Sign in using Google+ API </div><div class="clear"></div>
						<div class="text2">- After signing in a user can</div><div class="clear"></div>
						<div class="text"># update profile information</div><div class="clear"></div>
						<div class="text"># add child/ children</div><div class="clear"></div>
						<div class="text"># moniter vaccination progrees using customized schedule</div><div class="clear"></div>
						<div class="text"># chat with other online parents</div><div class="clear"></div>
						<div class="text"># ask queries live from our vaccination expert*</div><div class="clear"></div>
					</div>
					
					<div class="grid_3">
						<div class="text1">Steps</div>
						<div class="text2">
							- Click on 'Sign in with Google' button
						</div>
					</div>
					<!-- 
					<div class="grid6">
						<div class="text1">Register</div>
						<form id="form">
						<div class="success_wrapper">
						<div class="success">Connecting...<br>
						<strong>VacciBot will attend you soon..</strong> </div></div>
						<fieldset>
						<label class="name">
						<input type="text" value="Your Name:">
						<br class="clear">
						<span class="error error-empty">*This is not a valid name.</span><span class="empty error-empty">*This field is required.</span> </label>
						
						<br class="clear">
						<label class="email">
						<input type="text" value="your E-mail:">
						<br class="clear">
						<span class="error error-empty">*This is not a valid email address.</span><span class="empty error-empty">*This field is required.</span> </label>
						
						<label class="message">
						<textarea>Message:</textarea>
						<br class="clear">
						<span class="error">*The message is too short.</span> <span class="empty">*This field is required.</span> </label>
						
						<div class="clear"></div>
						<div class="btns"><a data-type="submit" class="link1">Register</a>
						<div class="clear"></div>
						</div></fieldset></form>
					</div>
					 -->
				</div>
					</br>	</br>
				* Note : As of now, our vaccination expert is available between 9pm - 9:30pm IST (UTC + 5:30), everyday.
				
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
