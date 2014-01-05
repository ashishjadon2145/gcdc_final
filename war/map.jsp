<%@ page import="java.util.List" %>
<%@ page import= "java.util.Iterator" %>
<%@ page import= "com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter" %>

<!DOCTYPE html>
<html>
<head>
 <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script>

var test = [];


function initialize()
{
	alert("s");
var foo = new google.maps.LatLng(28.535002, 77.105508)
var mapProp = { 
  center: foo ,
  zoom:8,
  mapTypeId:google.maps.MapTypeId.ROADMAP
  };
  alert("1");
var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);


var infowindow = new google.maps.InfoWindow();



var marker, i;

for (i = 0; i < test.length; i++) {  
    marker = new google.maps.Marker({
      position: new google.maps.LatLng(test[i][1], test[i][2]),
      map: map
    });

    google.maps.event.addListener(marker, 'click', (function(marker, i) {
      return function() {
        infowindow.setContent(test[i][0]);
        infowindow.open(map, marker);
      }
    })(marker, i));
  }
}


</script>
</head>

<body onload="initialize()">

<%
 List list = (List)request.getAttribute( "resultList" ); 
 Iterator<Object[]> i = list.iterator();
 System.out.println("iterator = "+i);
 int k = 0;
 while (i.hasNext())

	{
	    Object[] pd = i.next();	
		int pin_db = (Integer) pd[0];
		String name = (String)pd[1];
		String centername = (String)pd[1];
		String xcor = (String)pd[2];
		String ycor = (String)pd[3];
		
		%>
		  <script language=javascript>  
		test.push(["<%= centername %>", <%= xcor %> , <%= ycor %> ,"<%= pin_db %>" ]);
		</script>  
		<%
		k++;
	}
 
 %>
  
<script language=javascript>
alert("d"+test[0][0]);

</script>


<div id="googleMap" style="width:500px;height:380px;"></div>

</body>
</html>
