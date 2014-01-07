package com.osahub.hcs.vaccinate.controller.register;

import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.joda.time.LocalDate;

import com.googlecode.objectify.cmd.Query;
import com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter;
import com.osahub.hcs.vaccinate.dao.registration.Person;
import com.osahub.hcs.vaccinate.dao.user.AppointmentDao;
import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;

public class AppointmentHandler extends HttpServlet {
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
		if(actionSource.equalsIgnoreCase("parent")){
			String userId = session.getAttribute("userId").toString();
			Person parent =  OfyService.ofy().load().type(Person.class).id(userId).get();
		}
		//if request comes from immunization center screen
		else if(actionSource.equalsIgnoreCase("hospital") || actionSource.equalsIgnoreCase("freelancer")){
			String hospitalEmailId = session.getAttribute("hospitalEmailId").toString();
			VaccinationCenter hospital = OfyService.ofy().load().type(VaccinationCenter.class).filter("email", hospitalEmailId).first().get();
		}

		String servletAction = req.getParameter("action").toString();
		if(servletAction.equalsIgnoreCase("addAppointment")){
			String inputPincode_str = req.getParameter("hospitalName");
			int inputPincode = Integer.parseInt(inputPincode_str);
			String patientId = req.getParameter("patientId");
			String patientName = req.getParameter("patientName");
			if(patientName == null || patientName.trim().length()<1)
				patientName = "Not Available";
			String patientContact = req.getParameter("patientContact");
			if(patientContact == null || patientContact.equalsIgnoreCase("null") || patientContact.trim().length()<1)
				patientContact = "Not Available";
			

			int year = Integer.parseInt(req.getParameter("yappointment"));
			int month = Integer.parseInt(req.getParameter("mappointment"));
			int day = Integer.parseInt(req.getParameter("dappointment"));
			
			String appointmentDate = new LocalDate(year,month,day).toString();
			

			Integer appointmentCount = getAppointmentEntityCount();

			VaccinationCenter servingCenter = getVacciCenterFromPincode(getNearestPincodeWithVacciCenter(inputPincode));
			
			AppointmentDao tareekh = new AppointmentDao(new  Long(appointmentCount+1), appointment_status_open, patientId, patientContact, patientName, appointmentDate, appointment_category_home_vaccination, servingCenter.id, servingCenter.name, servingCenter.contact1, appointment_description_empty, patientId, "No Comments");
			ofy().save().entities(tareekh);
			ofy().clear();
			resp.sendRedirect("/parentHome?status=104#homeConsult");
		}
		else if(servletAction.equalsIgnoreCase("approveAppointment")){
			String appointmentIdList = 	(String)req.getParameter("approveUserList");
			String newApptActionList = 	(String)req.getParameter("newApptActionList");
			String newApptCommentList = (String)req.getParameter("newApptCommentList");
			
			String apptIdList[]=appointmentIdList.split(",");
			String apptActionList[]=newApptActionList.split(",");
			String apptCommentList[]=newApptCommentList.split(",");
			
			for(int i=0;apptIdList.length>i;i++){
				AppointmentDao appt = OfyService.ofy().load().type(AppointmentDao.class).id(Long.parseLong(apptIdList[i])).get();
				appt.status=Integer.parseInt(apptActionList[i]);
				appt.notes=apptCommentList[i];
				OfyService.ofy().save().entities(appt);
			}
			resp.sendRedirect("/"+actionSource+"Home?status=105#main-content");
		}
		else if(servletAction.equalsIgnoreCase("closeAppointment")){
			String appointmentIdList = 	(String)req.getParameter("closeUserList");
			String newApptActionList = 	(String)req.getParameter("acceptedApptActionList");
			String newApptCommentList = (String)req.getParameter("acceptedApptCommentList");
			
			String apptIdList[]=appointmentIdList.split(",");
			String apptActionList[]=newApptActionList.split(",");
			String apptCommentList[]=newApptCommentList.split(",");
			
			for(int i=0;apptIdList.length>i;i++){
				AppointmentDao appt = OfyService.ofy().load().type(AppointmentDao.class).id(Long.parseLong(apptIdList[i])).get();
				appt.status=Integer.parseInt(apptActionList[i]);
				appt.notes=apptCommentList[i];
				OfyService.ofy().save().entities(appt);
			}
			resp.sendRedirect("/"+actionSource+"Home?status=106#main-content");
		}
	}
	
	public int getAppointmentEntityCount(){
		Integer count = ofy().load().type(AppointmentDao.class).count();
		if(count == null)
			return 0;
		else 
			return count;
	}
	
	public VaccinationCenter getVacciCenterFromPincode(int pincode){
		List<VaccinationCenter> VaccinationCenterList = new ArrayList<VaccinationCenter>();
		VaccinationCenterList = getVacciCenterListFromPincode(pincode);
		return VaccinationCenterList.get(0);
	}
	
	public List<VaccinationCenter> getVacciCenterListFromPincode(int pincode){
		List<VaccinationCenter> VaccinationCenterList = new ArrayList<VaccinationCenter>();
		
		Query<VaccinationCenter> q = ofy().load().type(VaccinationCenter.class).filter("pincode =", pincode);
		
		Iterator<VaccinationCenter> ii = q.iterator();
		while(ii.hasNext()){
			VaccinationCenterList.add(ii.next());
		}
		
		return VaccinationCenterList;
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
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException { 
		resp.sendRedirect("/index.jsp");
	}
}