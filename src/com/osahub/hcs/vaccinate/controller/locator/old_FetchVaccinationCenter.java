package com.osahub.hcs.vaccinate.controller.locator;

import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.cmd.Query;
import com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter;

@SuppressWarnings("serial")
public class old_FetchVaccinationCenter extends HttpServlet {

	List<Integer> pinCodeList = new ArrayList<Integer>();
	String add1;
	String timing;
	String name;
	String contact1;
	double xCor;
	double yCor;
	int pinCode;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		
		
		int pincode = Integer.parseInt(request.getParameter("fetchpin"));
		int finalPincode;

		finalPincode = getNearestPincodeWithVacciCenter(pincode);
		Query<VaccinationCenter> q = ofy().load().type(VaccinationCenter.class).filter("pincode =", finalPincode);
		
		Iterator<VaccinationCenter> ii = q.iterator();
		while(ii.hasNext()){
			
			
			VaccinationCenter pd = ii.next();
			name = pd.name;
			contact1 =pd.contact1;
			pinCode = pd.pincode;
			xCor = pd.xCor;
			yCor = pd.yCor;
			add1 = pd.add1;
			timing = pd.workingHours;
		}
		
		request.setAttribute("contact1", contact1);
		request.setAttribute("name", name);
		request.setAttribute("pinCode", pinCode);
		request.setAttribute("add1", add1);
		request.setAttribute("timing", timing);
		request.setAttribute("xCor", xCor);
		request.setAttribute("yCor", yCor);
		request.getRequestDispatcher("map.jsp").forward(request, response);
	}
	
	public int getNearestPincodeWithVacciCenter(int inputPincode){
		List<Integer> pinCodeList = new ArrayList<Integer>();
		pinCodeList = getNearestPincodeListWithVacciCenter(inputPincode);
		return pinCodeList.get(0);
	}
	
	public List<Integer> getNearestPincodeListWithVacciCenter(int inputPincode){
		List<Integer> pinCodeList = new ArrayList<Integer>();
		
		List<VaccinationCenter> cars = (List<VaccinationCenter>) ofy().load().type(VaccinationCenter.class).list();
		
		Iterator<VaccinationCenter> i = cars.iterator();

		int min = 0;
		int count = 1;
		
		while (i.hasNext())
		{
			int pin_db = (Integer) i.next().pincode;
			//System.out.println("------- " + pin_db);
			if (count == 1) {
				min = Math.abs(pin_db - inputPincode);
				pinCodeList.add(pin_db);
			}

			else {
				if (min > Math.abs(pin_db - inputPincode)) {
					min = Math.abs(pin_db - inputPincode);
					pinCodeList.clear();
					pinCodeList.add(pin_db);
				}
				else if (min == Math.abs(pin_db - inputPincode)) {
					min = Math.abs(pin_db - inputPincode);
					pinCodeList.add(pin_db);
				}
			}
			count++;
		}
		return pinCodeList;
	}
}