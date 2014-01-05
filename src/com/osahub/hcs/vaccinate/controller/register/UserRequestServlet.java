package com.osahub.hcs.vaccinate.controller.register;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.googlecode.objectify.cmd.Query;
import com.osahub.hcs.vaccinate.dao.registration.Person;
import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;


public class UserRequestServlet extends HttpServlet {
	
	private List<Object[]> userRequestList = new ArrayList<Object[]>();
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse resp) throws IOException {
		userRequestList.clear();
		System.out.println("hi there...");
		Query<Person> p = OfyService.ofy().load().type(Person.class).filter("mobileVerified", false);
		List<?> allPList = p.list();
		System.out.println("allAPList" + allPList.size());
		DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
		for (Person person: p) 
		{	
			String[] tempList = new String[5];
			tempList[0] = (String)person.name;
			tempList[1] = (String)person.email;
			tempList[2] = df.format(person.registrationDate);
			tempList[3] = String.valueOf(person.childCount);
			tempList[4] = (String)person.mobile;
			
			userRequestList.add(tempList);
			
		    System.out.println(person.name);
		    System.out.println(person.email);
		    System.out.println(person.registrationDate);
		    System.out.println(person.childCount);
		    System.out.println(person.mobile);
		 }
		HttpSession session = request.getSession();
		session.setAttribute("userList", userRequestList);
		resp.sendRedirect("/test.jsp");	
	}
}