<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>GCDC 2013 : Vaccinate|Scheduler</title>
		<link rel="icon" href="images/favicon.ico">
		<link rel="shortcut icon" href="images/favicon.ico" />
		<link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="css/camera.css">
		<link rel="stylesheet" href="css/form.css">
		<link rel="stylesheet" href="css/foundation.css">
		<!-- <link rel="stylesheet" href="css/foundation.css"> -->
		<script src="js/jquery.js"></script>
		<script src="js/jquery-migrate-1.1.1.js"></script>
		<!-- ><script src="js/superfish.js"></script> -->
		<script src="js/forms.js"></script>
		<script src ="js/foundatio.min.js"></script>
		<script src="js/jquery.ui.totop.js"></script>
		<script src="js/jquery.equalheights.js"></script>
		<script src="js/jquery.easing.1.3.js"></script>
		<script src="js/jquery.ui.totop.js"></script>
		
		
		<script src="js/modernizr.foundation.js"></script>
		
		<script src="js/tms-0.4.1.js"></script>
		<script>
			/*$(document).ready(function(){
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
			});*/
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
				/*$(document).ready(function(){
					$().UItoTop({ easingType: 'easeOutQuart' });
				});*/
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
$( "#datepicker" ).datepicker({
changeMonth: true,
changeYear: true
});
});

</script>
<link rel="stylesheet" href="/css/calander-style.css" />
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
								<li class=""><a href="/index.html">Home </a> <strong class="hover"></strong></li>
								<li class="current men"><a onClick="goToByScroll('page5'); return false;" href="#">FAQs</a> <strong class="hover"></strong></li>
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
						<h3>Got Any Question?</h3>
						<div class="text1">
							Check our Frequently Asked Questions. If you are not satisfied mail to us or talk to our expert
								<hr />
						</div>
					</div>
				</div>
				<div class="clear"></div>
				
			
				<div class="map">
						<div class="grid_12">
						<!-- FaQ -->
						<ul class="accordion">
	      		<li>
	      			<div class="title">
	      			<h5>What is immunization and how does it work ?</h5>
	      			</div>
	      			<div class="accontent">
	      			<p>
	      			Immunization is a way of protecting the human body against infectious diseases through vaccination. Immunization prepares our bodies to fight against diseases in case we come into contact with them in the future. Babies are born with some natural immunity which they get from their mother and through breast-feeding. This gradually wears off as the baby's own immune system starts to develop. Having your child immunized gives extra protection against illnesses which can kill. 
	      			</p>
	      			</div>
	      		</li>
	      	
	      		<li>
	      			<div class="title">
	      			<h5>The schedule recommends that that the vaccinations should start when the baby is 1 1/2 months old. But what should be done if the baby is brought late for vaccinations? Should vaccination still be started?</h5>
	      			</div>
	      			<div class="accontent">
	      			<p>Yes, definitely. Even if the baby is brought late for vaccinations, she should still receive all the vaccinations. While it is the best to follow the ideal immunization schedule, on no account should the baby be denied vaccinations, even if she is brought late for them. But every attempt must be made to complete full immunization, before the age of 1 year.</p>
	      			</div>
	      		</li>
	      		
	      		<li>
	      			<div class="title">
	      			<h5>My friend's baby, who was given the B.C.G. injection about two months ago, has developed a small blister at the site of injection. Is this a cause for worry?</h5>
	      			</div>
	      			<div class="accontent">
	      			<p>Please reassure your friend that there is no cause for worry. This is a normal reaction after the B.C.G. injection. About 4 to 6 weeks after B.C.G. injection a small lump called a papule appears at a of the injection which may later break, giving out a whitish discharge. This will heal in about 10 to 12 weeks after the injection has been given and will leave a scar. Only if the discharge continues without the wound drying up, should the doctor be consulted.</p>
	      			</div>
	      		</li>
	      		
	      		
	      		<li>
	      			<div class="title">
	      			<h5>Sometimes it is not possible to take the baby for the second and third vaccinations after precisely a month. If so, should the whole course be repeated?</h5>
	      			</div>
	      			<div class="accontent">
	      			<p>No, a slight delay does not matter. Continue the vaccinations as per the schedule and complete the course as soon as possible. The child will be fully protected only after she has received 1 B.C.G. injection. 3 D.P.T. injections, 3 O.P.V. doses and 1 measles injection. Hence it is very important to take the baby for the vaccination at the correct time and to make sure that all the vaccinations are given.</p>
	      			</div>
	      		</li>
	      		
	      		
	      		<li>
	      			<div class="title">
	      			<h5>Are there any reasons why my child should not be immunized?</h5>
	      			</div>
	      			<div class="accontent">
	      			<p>There are very few reasons why a child should not be immunized. Ordinarily common illnesses like a cold or a diarrhea are not impediments against getting your child vaccinated.There are certain situations though, where you must let your healthcare provider know of your child's conditions. Following are some of them:
						</p><ul>
    					<li>The child has a high fever.</li>
    					<li> The child had a bad reaction to another immunization;</li>
    					<li>The child has had a severe reaction after eating eggs; or</li>
    					<li>The child had convulsions (fits) in the past. (With the right advice, children who have had fits in the past can be immunized.)</li>
    					<li>The child had, or is having, treatment for cancer;</li>
    					<li>The child any illness which affects the immune system, for example, HIV or AIDS.</li>
    					<li>The child is taking any medicine which affects the immune system, for example, immunosuppressants (given after organ transplant or for malignant disease) or high-dose steroids.</li>
	      			</ul>
	      			</div>
	      		</li>
	      		
	      		
	      		<li>
	      			<div class="title">
	      			<h5> How do we know that vaccines are safe?</h5>
	      			</div>
	      			<div class="accontent">
	      			<p>Vaccines like all other medicines under go extensive and rigorous tests regarding their safety. Only after the have been found to be safe that they are introduced for general vaccination programs. Each vaccine is continually checked even after it has been introduced and action is taken if it is needed. If a vaccine is not safe it is not used.</p>
	      			</div>
	      		</li>
	      		
	      		
	      		<li>
	      			<div class="title">
	      			<h5> I delete the confirmation mail by mistake. How should I activate my account?</h5>
	      			</div>
	      			<div class="accontent">
	      			<p>Please click on the following <a href="#" class="backJob">link</a>.</p>
	      			</div>
	      		</li>
	      		
	      		
	      		<li>
	      			<div class="title">
	      			<h5>I do not want to receive vaccination reminder anymore. What should I do to end the subscription ?</h5>
	      			</div>
	      			<div class="accontent">
	      			<p>Please click on the following <a href="#" class="backJob">link</a> to end your subscription and do not forgot to provide your valuble feedback.</p>
	      			</div>
	      		</li>
	      	     		
	      	
	      	</ul>
						<!-- FaQ -->
						
						</div>					

				</div>
					</br>	</br>
				Note : As of now, we are using immunization schedule issued by Govt. of India and WHO for SEAR region.
			</div>
		</div>
		
		
<!--==============================footer=================================-->
		<footer>
			<div class="container_12">
				<div class="grid_12">
					<div class="copy">
						<a onClick="goToByScroll('page1'); return false;" href="#"><img src="images/footer_logo.png" alt=""></a>  &copy; 2013 | Privacy Policy <br> <br>.
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</footer>
		
		
		<script src="js/query.foundation.accordion.js"></script>
		<script src="js/app.js"></script>
	</body>
</html>
