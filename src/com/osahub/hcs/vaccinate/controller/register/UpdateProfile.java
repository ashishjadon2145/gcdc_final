package com.osahub.hcs.vaccinate.controller.register;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.joda.time.LocalDate;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.datastore.QueryResultIterator;
import com.googlecode.objectify.Key;
import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;
import com.osahub.hcs.vaccinate.util.DropdownUtil;
import com.osahub.hcs.vaccinate.controller.vaccinate.VaccibotClassify;
import com.osahub.hcs.vaccinate.dao.registration.Child;
import com.osahub.hcs.vaccinate.dao.registration.Person;
import com.osahub.hcs.vaccinate.dao.vaccibot.Vocabulary;

public class UpdateProfile extends HttpServlet {
	//Person p1;
	String  password;
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException { 
	    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
		HttpSession session = req.getSession();
		session.setAttribute("childName", null);
		session.setAttribute("dateOfBirth", null);
		
		//to handel request from parent, admin, volunteer and helpline  
		String actionSource = req.getParameter("source").toString();
		String sessionUserIdAttribue = DropdownUtil.getSessionPropertyNameFromActionSource(actionSource);
		String userId = session.getAttribute(sessionUserIdAttribue).toString();
		Person parent =  OfyService.ofy().load().type(Person.class).id(userId).get();
		
		String servletAction = req.getParameter("action").toString();
		
		if( servletAction.equalsIgnoreCase("updatePersonDetails")){
	        String name = req.getParameter("name").toString();
	        String email = req.getParameter("email").toString();
	        String mobile = req.getParameter("mobile").toString();
	        String addressLine1 = req.getParameter("addressLine1").toString();
	        String locality = req.getParameter("locality").toString();
	        String district = req.getParameter("district").toString();
	        String city = req.getParameter("city").toString();
	        String state = req.getParameter("state").toString();
	        int pin = Integer.parseInt(req.getParameter("pin").toString());
	        //int country = Integer.parseInt(req.getParameter("country").toString());
	        
			Map<String, BlobKey> blobs = blobstoreService.getUploadedBlobs(req);
	        BlobKey image1 = blobs.get("image1_small");
	        parent.image1 = image1;
	        parent.name = name;
	        parent.email = email;
	        parent.mobile = mobile;
	        parent.addressLine1 = addressLine1;
	        parent.locality = locality;
	        parent.district = district;
	        parent.city = city;
	        parent.state = state;
	        parent.pin = pin;
	        //parent.country = country;
	        OfyService.ofy().save().entities(parent);
	        OfyService.ofy().clear();
	        resp.sendRedirect("/parentHome?status=100");
		}
		else if(servletAction.equalsIgnoreCase("addChild")){
			if(parent.childCount < 5){
				try{
					parent.childCount = parent.childCount+1;
			        OfyService.ofy().save().entities(parent);
			        OfyService.ofy().clear();
			        
					String cName = req.getParameter("cName").trim().toUpperCase();
					int year = Integer.parseInt(req.getParameter("ydob"));
					int month = Integer.parseInt(req.getParameter("mdob"));
					int day = Integer.parseInt(req.getParameter("ddob"));
					
					String dob = new LocalDate(year,month,day).toString();
					int age = getAge(day, month, year);
					
					Key<Person> pKey = Key.create(parent);
					Child c = new Child(pKey, cName, userId, dob, age);
			        OfyService.ofy().save().entities(c);
			        OfyService.ofy().clear();
					
					resp.sendRedirect("/parentHome?status=101#main-content");
				}catch(Exception e){
					e.printStackTrace();
					resp.sendRedirect("/parentHome?status=102#main-content");
				}
			}else{ 
				resp.sendRedirect("/parentHome?status=103#main-content");
			}

		}
		else if(servletAction.equalsIgnoreCase("updateHelplineDetails")){
			String name = req.getParameter("name").toString();
	        String email = req.getParameter("email").toString();
	        String mobile = req.getParameter("mobile").toString();
	       
	        
			Map<String, BlobKey> blobs = blobstoreService.getUploadedBlobs(req);
	        BlobKey image1 = blobs.get("image1_small");
	        parent.image1 = image1;
	        parent.name = name;
	        parent.email = email;
	        parent.mobile = mobile;
	       
	        OfyService.ofy().save().entities(parent);
	        OfyService.ofy().clear();
	        resp.sendRedirect("/"+actionSource+"Home?status=100");
		}
		else if(servletAction.equalsIgnoreCase("startMonitorChild")){

	        String dobName = req.getParameter("childId").toString();
			session.setAttribute("childName", dobName.substring(10));
			session.setAttribute("dateOfBirth", dobName.substring(0,10));
			resp.sendRedirect("/parentHome#main-content");

		}
		else if(servletAction.equalsIgnoreCase("stopMonitorChild")){
			session.setAttribute("childName", null);
			session.setAttribute("dateOfBirth", null);
			resp.sendRedirect("/parentHome#main-content");
		}
		else if(servletAction.equalsIgnoreCase("updateHospitalDetails")){
			session.setAttribute("childName", null);
			session.setAttribute("dateOfBirth", null);
			resp.sendRedirect("/hospitalHome#start");
		}
		
		
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException { 
		resp.sendRedirect("/index.html");
	}
		
	public static ArrayList<Child> getChildListFromParentEmail(String parentEmail){
		ArrayList<Child> childList = new ArrayList<>();
		QueryResultIterator<Child> childIterator = OfyService.ofy().load().type(Child.class).filter("parentMailId",parentEmail).iterator();
		if( childIterator != null){
			while(childIterator.hasNext()){
				childList.add(childIterator.next());
			}
		}
		return childList;
	}
	
	/*
	
	public boolean childExists(String mobile, String cName){	
		String hash = Hasher.CreateHash(mobile+cName);
		Child p = OfyService.ofy().load().type(Child.class).filter("hash", hash).first().get();
		if (null != p)
			return true;
		return false;
	}
	
	public boolean parentExists(String mobile){	
		p1 =null;
		p1 = ofy().load().type(Person.class).id(mobile).get();
		if (null != p1)
			return true;
		return false;
	}*/

	public int getAge(int day,int month, int year)
	{
		Calendar rightNow = Calendar.getInstance(); 
		int m1 = rightNow.get(Calendar.MONTH)+1;
		int d1 = rightNow.get(Calendar.DAY_OF_MONTH);
		int y1 = rightNow.get(Calendar.YEAR);
		
		int m2=month;
		int d2= day;
		int y2=year;
		int aayu=0;
		aayu=aayu+365*(y1-y2)+30*(m1-m2)+(d1-d2);
		
		return aayu;
	}
}