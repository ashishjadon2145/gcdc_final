package com.osahub.hcs.vaccinate.controller.register;


import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;
import com.osahub.hcs.bean.mail.Sandesh;
import com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter;
import com.osahub.hcs.vaccinate.dao.registration.AccessControl;
import com.osahub.hcs.vaccinate.dao.registration.Person;

public class LoginServlet extends HttpServlet {
	String loginSource = null;
	Person p;
	HttpSession session ;
	int role;
	private static final int FRESH_EMAIL_ROLE_NOT_ADMIN = 1;
	private static final int FRESH_EMAIL_ROLE_IS_ADMIN = 2; 
	private static final int REGISTERED_EMAIL_ROLE_MATCHES = 3; 
	private static final int REGISTERED_EMAIL_ROLE_MISMATCH = 4; 
	private static final int PERSON = 1;
	private static final int VACCINATION_CENTER = 2; 
	private static final int HELPLINE = 3; 
	private static final int ADMIN = 4;  
	private static final int FREELANCER = 5;  
	private static final int VOLUNTEER = 6;  

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException { 
		this.role= Integer.parseInt(req.getParameter("role"));
		doPost(req, resp);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse resp) throws IOException {
		session = request.getSession();
		session.setAttribute("userId", null);
		session.setAttribute("hospitalEmailId", null);
		session.setAttribute("freelancerId", null);
		session.setAttribute("adminId", null);
		session.setAttribute("volunteerId", null);
		session.setAttribute("helplineID", null);
		session.setAttribute("childName", null);
		session.setAttribute("dateOfBirth", null);
		
		UserService userService;
		String loggedInUser = request.getUserPrincipal().getName().toUpperCase();
		try {
		  	userService = UserServiceFactory.getUserService();
			
	        if (request.getUserPrincipal() == null){
	    		session.setAttribute("userId", null);
	        	resp.sendRedirect("/index.jsp?status=4");
	        }
	        else{
	        	int registraionStatus = isUserRegistered(loggedInUser,this.role);
	        	
				
				if(registraionStatus == FRESH_EMAIL_ROLE_IS_ADMIN){
					resp.sendRedirect("/index.jsp?status=1");
				}else if(registraionStatus == REGISTERED_EMAIL_ROLE_MISMATCH){
					resp.sendRedirect("//index.jsp?status=2");
				}else{
					if(registraionStatus == FRESH_EMAIL_ROLE_NOT_ADMIN){
						
						//create a new entity in DB
						registeruser(loggedInUser,this.role);
						
						//send welcome mail
						sendWelcomeMail(loggedInUser);
						
					}

					//redirect to the desired page
					forwardToPage(resp, loggedInUser);
				}
					
			}
		}catch(Exception err){}
	}
	
	private void forwardToPage(HttpServletResponse resp, String loggedInUser) throws IOException{
		switch(this.role){
			case 1:
				resp.sendRedirect("/parentHome");
				//resp.sendRedirect("/adminPanel");//hardcoded to make admin screen
				session.setAttribute("userId", loggedInUser);
				break;
			case 2:
				resp.sendRedirect("/hospitalHome");
				session.setAttribute("hospitalEmailId", loggedInUser);//since hospital can  be added by admin, for them emailid!=id, id==hospital name. so using hospitalEmailId not hospitalId
				break;
			case 3:
				resp.sendRedirect("/helplineHome");
				session.setAttribute("helplineID", loggedInUser);//change userId to helplineID and test 
				break;
			case 4:
				resp.sendRedirect("/adminPanel");
				session.setAttribute("adminId", loggedInUser);//changed userId to adminID but not tested 
				break;
			case 5:
				resp.sendRedirect("/freelancerHome");
				session.setAttribute("freelancerId", loggedInUser);//since freelancer can not be added by admin, for them emailid==id, so using freelancerId not freelancerEmailId
				break;
			case 6:
				resp.sendRedirect("/volunteerHome");
				session.setAttribute("volunteerId", loggedInUser);
				break;
		}
	}
	
	public int isUserRegistered(String email, int role){
		AccessControl accessControl = null;
		VaccinationCenter vaccinationCenter = null;
		Person person = null;
		
		accessControl = OfyService.ofy().load().type(AccessControl.class).id(email).get();

		//email id does not exist in  our DB
		if(accessControl == null){
			//if some one is trying to login as admin
			if(role == ADMIN)
				return FRESH_EMAIL_ROLE_IS_ADMIN;
			else
				return FRESH_EMAIL_ROLE_NOT_ADMIN;
		}
		//email alreadly in our DB
		else{
			if(role == accessControl.role){
				switch(role){
					case VACCINATION_CENTER:
						//there is possibility of duplicacy where a vaccination center is already added by admin manuaaly and that center registers online 
						vaccinationCenter = OfyService.ofy().load().type(VaccinationCenter.class).filter("email", email).first().get();
						vaccinationCenter.lastLogin = "Your last login : "+new Date();
						ofy().save().entities(vaccinationCenter);
						ofy().clear();
						break;
					case FREELANCER:
						vaccinationCenter = OfyService.ofy().load().type(VaccinationCenter.class).filter("email", email).first().get();
						vaccinationCenter.lastLogin = "Your last login : "+new Date();
						ofy().save().entities(vaccinationCenter);
						ofy().clear();
						break;
					default:
						//i.e. Parent, Helpline, Admin, volunteer
						person = OfyService.ofy().load().type(Person.class).id(email).get();
						person.lastLogin = "Your last login : "+new Date();
						ofy().save().entities(person);
						ofy().clear();
						break;
				}
				return REGISTERED_EMAIL_ROLE_MATCHES;
			}
			else
				return REGISTERED_EMAIL_ROLE_MISMATCH;
		}
	}
	
	/*public int isUserRegistered(String email, int role){
		Object entity = null;
		
		switch(role){
			case VACCINATION_CENTER:
				//there is possibility of duplicacy where a vaccination center is already added by admin manuaaly and that center registers online 
				entity = OfyService.ofy().load().type(VaccinationCenter.class).filter("email", email).first().get();
				break;
			default:
				//i.e. Parent, Helpline, Admin
				entity = OfyService.ofy().load().type(Person.class).id(email).get();
				break;
		}
		
		//email id does not exist in  our DB
		if(entity == null){
			//if some one is trying to login as admin
			if(role == ADMIN)
				return FRESH_EMAIL_ROLE_IS_ADMIN;
			else
				//this will be returned even if email id not fresh. i.e email-id exixts in person/vaccination center DB entity/table.
				//So. it means a parent can register as a vaccination center and vice-versa.
				return FRESH_EMAIL_ROLE_NOT_ADMIN;
		}
		//email alreadly in our DB
		else{
			//check if registered user has same role as that of the login request
			//will always be true because if 'entity' is not 'null' here and 'role == VACCINATION_CENTER'
			//that means it has been fetched from  VaccinationCenter DB entity/table
			if(role == VACCINATION_CENTER && entity instanceof VaccinationCenter){
				VaccinationCenter center = (VaccinationCenter)entity;
				center.lastLogin = "Your last login : "+new Date();
				ofy().save().entities((VaccinationCenter)entity);
				ofy().clear();
				return REGISTERED_EMAIL_ROLE_MATCHES;
			}
			//will always return false.
			else if (role == VACCINATION_CENTER && !(entity instanceof VaccinationCenter)) {
				return REGISTERED_EMAIL_ROLE_MISMATCH;
			}
			//will always be true 
			else if (role != VACCINATION_CENTER && entity instanceof Person) {
				Person currentUser = (Person)entity;
				//check if a non-admin person is trying to login as admin
				if(role != currentUser.role)
					return REGISTERED_EMAIL_ROLE_MISMATCH;
				else{
					currentUser.lastLogin = "Your last login : "+new Date();
					ofy().save().entities((Person)entity);	
					ofy().clear();
					return REGISTERED_EMAIL_ROLE_MATCHES;
				}
			}
			//will always return false.
			else //if (role != VACCINATION_CENTER && !(entity instanceof Person)) {
				return REGISTERED_EMAIL_ROLE_MISMATCH;
			//}
		}
	}*/
	
	public void registeruser(String email, int role){
		AccessControl accessControl = null;
		accessControl = new AccessControl(email, role, "online@vaccinate.com");
		ofy().save().entities(accessControl);
		ofy().clear();
		
		switch(role){
		case VACCINATION_CENTER:
			VaccinationCenter vaccinationCenter = null;
			vaccinationCenter = new VaccinationCenter(email);
			ofy().save().entities(vaccinationCenter);
			ofy().clear();
			break;
		case FREELANCER:
			VaccinationCenter freelancer = null;
			freelancer = new VaccinationCenter(email);
			ofy().save().entities(freelancer);
			ofy().clear();
			break;
		default:
			Person parent = null;
			parent = new Person(email, new Date(), 1 , "online@vaccinate.com", role, getUsernameFromEmail(email));
			ofy().save().entities(parent);
			ofy().clear();
			break;
		}
	}
	
	public void sendWelcomeMail(String newUser){
		try{
			String mailBody="Dear User,\n\nThanks for registering with us.\n\nRegards,\nTeam Vaccinate";
			new Sandesh(newUser,newUser,"anshul@osahub.com","Team Vaccinate", "Welcome to Vaccinate.", mailBody).send();
		}catch(Exception m){}
	}
	
	private String getUsernameFromEmail(String email){
		String userName = "";
		if(email.endsWith("GMIAL.COM"))
			userName = email.substring(0, email.indexOf('@'));
		else
			userName = email.substring(0, email.indexOf('@'))+"-"+email.substring(email.indexOf('@')+1, email.lastIndexOf('.'));
		return userName;
	}
}