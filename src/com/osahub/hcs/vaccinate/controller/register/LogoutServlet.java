package com.osahub.hcs.vaccinate.controller.register;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class LogoutServlet  extends HttpServlet{

	HttpSession session ;
	public void doGet(HttpServletRequest request, HttpServletResponse resp) throws IOException {
		session = request.getSession();
		session.setAttribute("userId", null);
		session.setAttribute("hospitalEmailId", null);
		session.setAttribute("freelancerId", null);
		session.setAttribute("adminId", null);
		session.setAttribute("volunteerId", null);
		session.setAttribute("helplineID", null);
		UserService userService = UserServiceFactory.getUserService();
		String thisURL="/registration";
		if (request.getUserPrincipal() != null )
			resp.sendRedirect(userService.createLogoutURL(thisURL));
		else
			resp.sendRedirect("/registration");
		
	}
}
