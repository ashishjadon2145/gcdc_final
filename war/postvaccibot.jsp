<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>GCDC 2013 : Vaccinate|Vaccibot</title>
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
		<!--for vaccibot -->
		<script src="js/vaccibot.js"></script>
		<script src="js/sessvar.js"></script>
		<script type="text/javascript" >

function setName(){

sessvars.username = document.getElementById("userName").value;

}


</script>
		
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
					<h1><a href="index.html" ><img src="images/logo.png" alt="Gerald Harris attorney at law"></a></h1>
					<div class="menu_block">
						<nav class="">
							<ul class="sf-menu">
								<li class=""><a href="/index.html">Home </a> <strong class="hover"></strong></li>
								<li class="current men"><a onClick="goToByScroll('page5'); return false;" href="#">VacciBot</a> <strong class="hover"></strong></li>
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
						<h3>VacciBot</h3>
						<div class="text1">
							Helps you Resolve, All your vaccination related Queries
						</div>
					</div>
				</div>
				<div class="clear"></div>
				<div class="map">
					
			

				
				
				
				<div class="grid_4">
						<div class="text1">Conversation : </div>
				
					<div id="list"  class="grid_4"  style="overflow: auto;height:200px;background-color: lightblue">

						<div id="vaccibotBox"   style="color: black; background-color: lightblue">	
							<b>Vaccibot</b>: Hello. Please ask your query </br> 
						</div>
							
							
					
					</div>
						
						<br class="clear">
						<label>Say something here:</label>
						<textarea  class="grid_4" style="color: grey; background-color: lightblue" name="comments" id="comments"></textarea>
						
						<br class="clear">
						<div class="btns">
							<a  class="link1" onclick="addText();">Submit</a>
						</div>
						



				</div>
				
					<div class="grid_3">
						<div class="text1">Steps</div>
						<div class="text2">
							- Enter your query in the textarea below<div class="clear"></div>
							- Click on 'Submit'
						</div>
					</div>
				
					<!--  <div class="grid_5">
						<div class="text1">Sample Queries</div>
						- Available 24X7<div class="clear"></div>
						- Answers your vaccination related queries<div class="clear"></div>
						- No Registration/Login required<div class="clear"></div>
						- You can email the entire conversation to yourself<div class="clear"></div>
					</div> -->
					
				</div>
					</br>	</br>
				Note : Here we are using machine learning concepts and our VacciBOT is not fully trained yet.
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
