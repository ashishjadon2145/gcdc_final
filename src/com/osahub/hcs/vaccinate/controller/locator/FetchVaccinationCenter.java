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

import com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter;

@SuppressWarnings("serial")
public class FetchVaccinationCenter extends HttpServlet {

	List<Object[]> pinCodeList = new ArrayList<Object[]>();
	String centerName;
	double xCor;
	double yCor;
	int pinCode;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if(request.getParameter("action").equalsIgnoreCase("fetchLocationByPincode")){
			PrintWriter out = response.getWriter();
			int pincode = Integer.parseInt(request.getParameter("fetchpin"));
			int finalPincode;

			
			List<VaccinationCenter> cars = (List<VaccinationCenter>) ofy().load().type(VaccinationCenter.class).list();
			
			Iterator<VaccinationCenter> i = cars.iterator();

			int min = 0;
			int count = 1;
			pinCodeList.clear();
			while (i.hasNext()) {
				VaccinationCenter pd = i.next();
				int pin_db = (Integer) pd.pincode;
				
				if (count == 1) {
					min = Math.abs(pin_db - pincode);
					Object[] tempList = new Object[6];
						tempList[0] = pin_db;
						tempList[1] =  pd.name;
						tempList[2] = String.valueOf(pd.xCor);
						tempList[3] = String.valueOf(pd.yCor);
						tempList[4] = pd.contact1;
						tempList[5] = pd.add1;
						pinCodeList.add(tempList);
					
				}

				else {
					if (min > Math.abs(pin_db - pincode)) {
						min = Math.abs(pin_db - pincode);
						pinCodeList.clear();
						Object[] tempList = new Object[6];
						tempList[0] = pin_db;
						tempList[1] =  pd.name;
						tempList[2] = String.valueOf(pd.xCor);
						tempList[3] = String.valueOf(pd.yCor);
						tempList[4] = pd.contact1;
						tempList[5] = pd.add1;
						pinCodeList.add(tempList);

					}

					else if (min == Math.abs(pin_db - pincode)) {
						min = Math.abs(pin_db - pincode);
						Object[] tempList = new Object[6];
						tempList[0] = pin_db;
						tempList[1] =  pd.name;
						tempList[2] = String.valueOf(pd.xCor);
						tempList[3] = String.valueOf(pd.yCor);
						tempList[4] = pd.contact1;
						tempList[5] = pd.add1;
						pinCodeList.add(tempList);

					}

				}

				System.out.println("Difference " + min +"pincode ="+pin_db);

				count++;

			}

			request.setAttribute("resultList", pinCodeList);
			request.getRequestDispatcher("/locator").forward(request, response);
			
		}
		else if(request.getParameter("action").equalsIgnoreCase("fetchLocationByState")){
			String selectedItem;
			if(request.getParameter("Points")!=null){
				selectedItem=request.getParameter("Points");
				System.out.println(selectedItem);
   
				List<VaccinationCenter> cars = (List<VaccinationCenter>) ofy().load().type(VaccinationCenter.class).filter("state", selectedItem).list();
	
				Iterator<VaccinationCenter> i = cars.iterator();

				int min = 0;

				int count = 1;

				pinCodeList.clear();
				while (i.hasNext()){
					VaccinationCenter pd = i.next();
					Object[] tempList = new Object[6];
					tempList[0] = pd.pincode;
					tempList[1] =  pd.name;
					tempList[2] = String.valueOf(pd.xCor);
					tempList[3] = String.valueOf(pd.yCor);
					tempList[4] = pd.contact1;
					tempList[5] = pd.add1;
					pinCodeList.add(tempList);
				}
	
				request.setAttribute("resultList", pinCodeList);
				request.getRequestDispatcher("locator").forward(request, response);
			}
		}
	}
}