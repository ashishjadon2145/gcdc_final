package com.osahub.hcs.vaccinate.controller.locator;

import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter;
import com.osahub.hcs.vaccinate.dao.registration.AccessControl;

;

@SuppressWarnings("serial")
public class SaveVaccinationCenter extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String name = request.getParameter("name");
		String contact1 = request.getParameter("contact1");
		double xCor = Double.parseDouble(request.getParameter("xCor"));
		double yCor = Double.parseDouble(request.getParameter("yCor"));
		int pincode = Integer.parseInt(request.getParameter("pincode"));
		String add1 = request.getParameter("add1");
		String timing = request.getParameter("timing");

		VaccinationCenter pin1 = new VaccinationCenter(name, pincode, xCor,yCor, contact1, add1, timing, "ADMIN@OSAHUB.COM");

		ofy().save().entities(pin1);
		ofy().clear();


		response.sendRedirect("/adminPanel?status=110#locator");

	}

}