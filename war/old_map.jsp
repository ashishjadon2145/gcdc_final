<%
    String contact1 = request.getAttribute( "contact1" ).toString();
    String pinCode = request.getAttribute( "pinCode" ).toString();
    String xCor = request.getAttribute( "xCor" ).toString();
    String yCor = request.getAttribute( "yCor" ).toString();
    String name = request.getAttribute( "name" ).toString();
    String add1 = request.getAttribute( "add1" ).toString();
    String timing = request.getAttribute( "timing" ).toString();
    String description = name+"Address : "+add1+"PinCode : "+pinCode+"Contact  : "+contact1+"Timing : "+timing;
    System.out.println("description =  " + description);
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>GCDC 2013 : Vaccinate|Locator</title>
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
		function CaptchaNumber(evt){
                               var charCode = (evt.which) ? evt.which : event.keyCode;
                               if (charCode > 31  && (charCode < 48 || charCode > 57  )  )
                                       return false;
                               return true;
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
		<script
src="http://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
<script>
function initialize()
{
//alert(xCor);
//alert(yCor);
var foo = new google.maps.LatLng(xCor,yCor)
var mapProp = { 
  center: foo ,
  zoom:14,
  mapTypeId:google.maps.MapTypeId.ROADMAP
  };
var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);

var contentString ='<div id="content123" style="color: grey; background-color: lightblue">'+

'<h7>'+centerName+'</h7>'+

'<p>'+address+' </br> '+pincode+'  </br> '+contact+'</p>'+
'</div>';

var infowindow = new google.maps.InfoWindow({
    content: contentString
});


var marker = new google.maps.Marker({
    position: foo,
    map: map,
    title: centerName
});

google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map,marker);
  });


}

google.maps.event.addDomListener(window, 'load', initialize);
</script>

	</head>
	<body class="">
	    <script language=javascript>  
    var xCor = "<%= xCor %>";  
    var yCor = "<%= yCor %>";
    var centerName = "<%= name %>";
    var address = "<%= add1 %>";
    var pincode = "<%= pinCode %>";
    var contact = "<%= contact1 %>";

   
    </script>  
<!--==============================header=================================-->
		<header class="page1">
			<div class="container_12">
				<div class="grid_12">
					<h1><a href="#" onClick="goToByScroll('page1'); return false;"><img src="images/logo.png" alt="Gerald Harris attorney at law"></a></h1>
					<div class="menu_block">
						<nav class="">
							<ul class="sf-menu">
								<li class=""><a href="/index.jsp">Home </a> <strong class="hover"></strong></li>
								<li class="current men"><a onClick="goToByScroll('page5'); return false;" href="#">Locator</a> <strong class="hover"></strong></li>
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
			<div class="container_12">
				<div class="grid_12">
					<div class="slogan">
						<h3>VacciLocator</h3>
						<div class="text1">
							Helps you locate a vaccination center in your vicinity
						</div>
					</div>
				</div>
				<div class="clear"></div>
				<div class="map">
					
					<div class="grid_4">
						<div class="text1">Search Vaccination Center</div>
						
					<form id="form784" action="fetchLocation" method="post">

						<label>Enter Zip/ Post/ Pin Code</label></br>
						<input type="text"  maxlength="6"  style="color: grey; background-color: lightblue" onkeypress='return CaptchaNumber(event)'  name="fetchpin" id="fetchpin" /><br />
						<div class="btns">
							<a  class="link1" onclick="document.getElementById('form784').submit();">Search</a>
						</div>
					</form>
						
					</div>
					
					<div  id="googleMap" style="width:500px;height:380px;">
					
					</div>
				</div>
					</br>	</br>
				Note : As of now, our DB contains vaccination centers of New Delhi(India) only so please use zip/ post/ pin code between 110001 and 110099.

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
