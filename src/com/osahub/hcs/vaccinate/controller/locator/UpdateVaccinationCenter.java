package com.osahub.hcs.vaccinate.controller.locator;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter;
import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;
import com.osahub.hcs.vaccinate.util.DropdownUtil;

public class UpdateVaccinationCenter extends HttpServlet {
	//Person p1;
	String  password;
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException { 
	    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
		HttpSession session = req.getSession();
		session.setAttribute("childName", null);
		session.setAttribute("dateOfBirth", null);

		//to handel request from freelancer and hospital
		String actionSource = req.getParameter("source").toString();
		String sessionUserIdAttribue = DropdownUtil.getSessionPropertyNameFromActionSource(actionSource);
		
		String hospitalEmailId = session.getAttribute(sessionUserIdAttribue).toString();
		VaccinationCenter hospital =  OfyService.ofy().load().type(VaccinationCenter.class).filter("email", hospitalEmailId).first().get();
		
		String servletAction = req.getParameter("action").toString();
		
		if( servletAction.equalsIgnoreCase("updateVaccinationCenter")){
			//General Details
			String name = req.getParameter("name").toString();
	        String email = req.getParameter("email").toString();
	        String mobile1 = req.getParameter("mobile1").toString();
	        String mobile2 = req.getParameter("mobile2").toString();
	        String fax = req.getParameter("fax").toString();
	        //Operational Details
	        String workingHours = req.getParameter("workingHours").toString();
	        String weaklyHoliday= req.getParameter("weaklyHoliday").toString();
	        String vacciCenterType= req.getParameter("vacciCenterType").toString();
	        String homeServiceRadio= req.getParameter("homeServiceRadio").toString();
	        String homeVaccinationRange= req.getParameter("homeVaccinationRange").toString();
	        String aboutMe= req.getParameter("aboutMe").toString();
	       // String facilities= req.getParameter("HospFacilities").toString();
	        
	        //Address Details
	        String addressLine1 = req.getParameter("addressLine1").toString();
	        String pincodeFromMap = req.getParameter("pincodeFromMap").toString();
	        /*String locality = req.getParameter("locality").toString();
	        String district = req.getParameter("district").toString();
	        String city = req.getParameter("city").toString();
	        String state = req.getParameter("state").toString();
	        */
	        //int pin = Integer.parseInt(req.getParameter("pin").toString());
	        Double xCor = Double.parseDouble(req.getParameter("xCor").toString());
	        Double yCor = Double.parseDouble(req.getParameter("yCor").toString());
	        //int country = Integer.parseInt(req.getParameter("country").toString());
	        
			Map<String, BlobKey> blobs = blobstoreService.getUploadedBlobs(req);
	        BlobKey image1 = blobs.get("image1_small");
	        hospital.image1 = image1;
	        hospital.name = name;
	        hospital.email = email;
	        hospital.contact1 = mobile1;
	        hospital.contact2 = mobile2;
	        hospital.fax = fax;
	        hospital.workingHours=workingHours;
	        hospital.weaklyHoliday=Integer.parseInt(weaklyHoliday);
	        hospital.type = Integer.parseInt(vacciCenterType);
	        if(homeServiceRadio.equalsIgnoreCase("Yes"))
	        	hospital.homeVaccinationAvailable = true;
	        else
	        	hospital.homeVaccinationAvailable = false;
	        hospital.homeVaccinationRange = Integer.parseInt(homeVaccinationRange);
	        hospital.aboutMe=aboutMe;
	        hospital.facilities=aboutMe;
	        
	        
	        hospital.add1 = addressLine1;
	        hospital.xCor = xCor;
	        hospital.yCor = yCor;
	        hospital.add1 = addressLine1;
	       /* hospital.locality = locality;
	        hospital.district = district;
	        hospital.city = city;
	        hospital.state = state;
	       */
	       hospital.pincode = Integer.parseInt(pincodeFromMap);
	        //hospital.country = country;
	        OfyService.ofy().save().entities(hospital);
	        OfyService.ofy().clear();
	        resp.sendRedirect("/"+actionSource+"Home?status=100");
		}
		else if( servletAction.equalsIgnoreCase("updateVaccinationCenter")){
			//General Details
			String name = req.getParameter("name").toString();
	        String email = req.getParameter("email").toString();
	        String mobile1 = req.getParameter("mobile1").toString();
	        String mobile2 = req.getParameter("mobile2").toString();
	        String fax = req.getParameter("fax").toString();
	        //Operational Details
	        String workingHours = req.getParameter("workingHours").toString();
	        String weaklyHoliday= req.getParameter("weaklyHoliday").toString();
	        String vacciCenterType= req.getParameter("vacciCenterType").toString();
	        String homeServiceRadio= req.getParameter("homeServiceRadio").toString();
	        String homeVaccinationRange= req.getParameter("homeVaccinationRange").toString();
	        String aboutMe= req.getParameter("aboutMe").toString();
	       // String facilities= req.getParameter("HospFacilities").toString();
	        
	        //Address Details
	        String addressLine1 = req.getParameter("addressLine1").toString();
	        String pincodeFromMap = req.getParameter("pincodeFromMap").toString();
	        /*String locality = req.getParameter("locality").toString();
	        String district = req.getParameter("district").toString();
	        String city = req.getParameter("city").toString();
	        String state = req.getParameter("state").toString();
	        */
	        //int pin = Integer.parseInt(req.getParameter("pin").toString());
	        Double xCor = Double.parseDouble(req.getParameter("xCor").toString());
	        Double yCor = Double.parseDouble(req.getParameter("yCor").toString());
	        //int country = Integer.parseInt(req.getParameter("country").toString());
	        
			Map<String, BlobKey> blobs = blobstoreService.getUploadedBlobs(req);
	        BlobKey image1 = blobs.get("image1_small");
	        hospital.image1 = image1;
	        hospital.name = name;
	        hospital.email = email;
	        hospital.contact1 = mobile1;
	        hospital.contact2 = mobile2;
	        hospital.fax = fax;
	        hospital.workingHours=workingHours;
	        hospital.weaklyHoliday=Integer.parseInt(weaklyHoliday);
	        hospital.type = Integer.parseInt(vacciCenterType);
	        if(homeServiceRadio.equalsIgnoreCase("Yes"))
	        	hospital.homeVaccinationAvailable = true;
	        else
	        	hospital.homeVaccinationAvailable = false;
	        hospital.homeVaccinationRange = Integer.parseInt(homeVaccinationRange);
	        hospital.aboutMe=aboutMe;
	        hospital.facilities=aboutMe;
	        
	        
	        hospital.add1 = addressLine1;
	        hospital.xCor = xCor;
	        hospital.yCor = yCor;
	        hospital.add1 = addressLine1;
	       /* hospital.locality = locality;
	        hospital.district = district;
	        hospital.city = city;
	        hospital.state = state;
	       */
	       hospital.pincode = Integer.parseInt(pincodeFromMap);
	        //hospital.country = country;
	        OfyService.ofy().save().entities(hospital);
	        OfyService.ofy().clear();
	        resp.sendRedirect("/hospitalHome?status=100");
		}
		else if(servletAction.equalsIgnoreCase("startMonitorChild")){

	        String dobName = req.getParameter("childId").toString();
			session.setAttribute("childName", dobName.substring(10));
			session.setAttribute("dateOfBirth", dobName.substring(0,10));
			resp.sendRedirect("/hospitalHome#main-content");

		}
		else if(servletAction.equalsIgnoreCase("stopMonitorChild")){
			session.setAttribute("childName", null);
			session.setAttribute("dateOfBirth", null);
			resp.sendRedirect("/hospitalHome#main-content");
		}
		else if(servletAction.equalsIgnoreCase("updateHospitalDetails")){
			session.setAttribute("childName", null);
			session.setAttribute("dateOfBirth", null);
			resp.sendRedirect("/hospitalHome#start");
		}
		
		
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException { 
		resp.sendRedirect("/index.jsp");
	}
}