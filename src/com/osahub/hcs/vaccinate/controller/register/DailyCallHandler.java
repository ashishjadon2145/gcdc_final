package com.osahub.hcs.vaccinate.controller.register;

import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.osahub.hcs.vaccinate.dao.user.AppointmentDao;
import com.osahub.hcs.vaccinate.dao.user.CallRecordDao;
import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;

public class DailyCallHandler extends HttpServlet {
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
		
		if(servletAction.equalsIgnoreCase("callMade")){
			String appointmentIdList = 	(String)req.getParameter("approveUserList");
			String newApptActionList = 	(String)req.getParameter("newApptActionList");
			String newApptCommentList = (String)req.getParameter("newApptCommentList");
			
			String apptIdList[]=appointmentIdList.split(",");
			String apptActionList[]=newApptActionList.split(",");
			String apptCommentList[]=newApptCommentList.split(",");
			
			for(int i=0;apptIdList.length>i;i++){
				CallRecordDao appt = OfyService.ofy().load().type(CallRecordDao.class).id(Long.parseLong(apptIdList[i])).get();
				appt.status=Integer.parseInt(apptActionList[i]);
				appt.notes=apptCommentList[i];
				OfyService.ofy().save().entities(appt);
			}
			resp.sendRedirect("/"+actionSource+"Home?status=107#main-content");
		}
	}
	
	public int getAppointmentEntityCount(){
		Integer count = ofy().load().type(AppointmentDao.class).count();
		if(count == null)
			return 0;
		else 
			return count;
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException { 
		resp.sendRedirect("/index.html");
	}
}