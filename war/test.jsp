<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script language="javascript" src="javascripts/approveUser.js"></script>
</head>
<body>
<form name ="approveUser" action="approveUser" method="post" >
<input type="hidden" name="approveUserList" id="approveUserList">
<table width="100%" class="staterow" border="2">
<tr>
<td align="center" class="statelrow_odd"><font color="green" size="2"><b>User Name</b></font></td>
<td align="center" class="statelrow_odd"><font color="green" size="2"><b>Email ID</b></font></td>
<td align="center" class="statelrow_odd"><font color="green" size="2"><b>Registration Date</b></font></td>
<td align="center" class="statelrow_odd"><font color="green" size="2"><b>Child Count</b></font></td>
<td align="center" class="statelrow_odd"><font color="green" size="2"><b>Mobile No.</b> </font></td>
<td align="center" class="statelrow_odd"><font color="green" size="2"><b>Approve</b></font></td>

</tr>
<%
 List<Object[]> userList = (List)session.getAttribute("userList") ;
 int col;
 
 Iterator iterator = userList.iterator();

	
	  while (iterator.hasNext()) 
	  {
 %>
 
 <tr>
 <%
 
 Object[] row = (Object[])iterator.next(); System.out.println("");
   for ( col = 0; col < row.length; col++) 
   { 
	   %>
	   <td>
	   <%
       out.print(row[col]);
	   %>
	   </td>
	   
	   <%
   }
   %>
   <td width= 10% align="center">
   
   
   
		<input type="checkbox" name="approveMob" id="approveMob" value=" <%=row[col-1]  %>" />
		
	</td>
   </tr>
   <%
     
	  }
	  
	  %>
	  </table>
	  <table align="right" style="padding-right:10px;">
        <tr>
			<td style="padding-right:10px;">
			<input type="submit" value="approve" name="approve" onclick="return approve1()">
			
		</tr>

</table>
	  </form>
 </body>
</html>