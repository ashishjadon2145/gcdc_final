package com.osahub.hcs.vaccinate.controller.register;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter;
import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;

public class VaccinationCenterApprovalHandler extends HttpServlet {
	//Person p1;
	String  password;
	private final int appointment_status_open = 1;
	private final int appointment_category_home_vaccination = 1;
	private final String appointment_description_empty = "";
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException { 
//	    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
		HttpSession session = req.getSession();
		session.setAttribute("childName", null);
		session.setAttribute("dateOfBirth", null);
		
		String actionSource = req.getParameter("source").toString();
		//if request comes from parent screen
		

		String servletAction = req.getParameter("action").toString();
		
		if(servletAction.equalsIgnoreCase("approveVaccinationCenter")){
			String appointmentIdList = 	(String)req.getParameter("approveUserList");
			String newApptActionList = 	(String)req.getParameter("newApptActionList");
			String newApptCommentList = (String)req.getParameter("newApptCommentList");
			
			String apptIdList[]=appointmentIdList.split(",");
			String apptActionList[]=newApptActionList.split(",");
			String apptCommentList[]=newApptCommentList.split(",");
			
			for(int i=0;apptIdList.length>i;i++){
				VaccinationCenter appt = OfyService.ofy().load().type(VaccinationCenter.class).id(apptIdList[i]).get();
				
				appt.isVerified=Integer.parseInt(apptActionList[i]);
				
				appt.verifiedComment=apptCommentList[i];
				
				if(session.getAttribute("userId")!=null)
					appt.verifiedBy=session.getAttribute("userId").toString();
				else
					appt.verifiedBy=session.getAttribute("userId").toString();
				
				appt.verifiedOn=new Date().toString();
				
				OfyService.ofy().save().entities(appt);
			}
			resp.sendRedirect("/adminHome?status=111#main-content");
		}
	}
	
			
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException { 
		resp.sendRedirect("/index.html");
	}
	

}