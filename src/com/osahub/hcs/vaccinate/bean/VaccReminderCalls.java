package com.osahub.hcs.vaccinate.bean;

import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;
import com.osahub.hcs.vaccinate.dao.registration.Child;
import com.osahub.hcs.vaccinate.dao.registration.Person;
import com.osahub.hcs.vaccinate.dao.user.CallRecordDao;

/*
 * This class is to make list of users to be called every day
 * This is run after Postman  and MUST be run after that
 * */ 
public class VaccReminderCalls extends HttpServlet {
	
	public int getCallRecordEntityCount(){
		Integer count = ofy().load().type(CallRecordDao.class).count();
		if(count == null)
			return 0;
		else 
			return count;
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	
		StringBuffer tikas = new StringBuffer();
		List<Child> children = ofy().load().type(Child.class).list();
		 
		for(Child c : children){
			boolean flag = false;
			boolean todayIsDueDate = true;
			String childName = c.name;
			int ageInDays = c.ageInDays++;
	       
			switch(ageInDays){
				case 1:
					flag = true;
					tikas.append("\n1. B.C.G. (injection) </br>2. Hep-B 1");
					break;
					
				case 41:
					flag = true;
					tikas.append("\n1. DTP 1 </br>2. IPV 1</br>2. Hep-B 2</br>3. Hib 1</br>4. Rotavirus 1</br>5. PCV 1");
					break;
					
				case 42:
					flag = true;
					tikas.append("\n1. DTP 1 </br>2.  IPV 1 </br>2. Hep-B 2 </br>3. Hib 1 </br>4. Rotavirus 1 </br>5. PCV 1");
					todayIsDueDate = false;
					break;
					
					
				case 69:
					flag = true;
					tikas.append("\n1. DTP 2 </br>2.  IPV 2 </br>3. Hib 2 </br>4. Rotavirus 2 </br>5. PCV 2");
					
					break;
					
				case 70:
					flag = true;
					tikas.append("\n1. DTP 2 </br>2.  IPV 2 </br>3. Hib 2 </br>4. Rotavirus 2 </br>5. PCV 2");
					todayIsDueDate = false;
					break;
					
				case 97:
					flag = true;
					tikas.append("\n1. DTP 3 </br>2.  IPV 3 </br>3. Hib 3 </br>4. Rotavirus 3 </br>5. PCV 3");
					
					break;
					
				case 98:
					flag = true;
					tikas.append("\n1. DTP 3 </br>2.  IPV 3 </br>3. Hib 3 </br>4. Rotavirus 3 </br>5. PCV 3");
					todayIsDueDate = false;
					break;
					
				case 181:
					flag = true;
					tikas.append("\n1. OPV 1 </br>2.  Hep-B 3");
					
					break;
					
				case 182:
					flag = true;
					tikas.append("\n1. OPV 1 </br>2.  Hep-B 3");
					todayIsDueDate = false;
					break;
					
				case 272:
					flag = true;
					tikas.append("\n1. OPV 2 </br>2. Measles");
					
					break;
					
				case 273:
					flag = true;
					tikas.append("\n1. OPV 2 </br>2. Measles");
					todayIsDueDate = false;
					break;
					
				case 364:
					flag = true;
					tikas.append("\n1.Hep-A 1");
					
					break;
					
				case 365:
					flag = true;
					tikas.append("\n1.Hep-A 1");
					todayIsDueDate = false;
					break;
					
				case 455:
					flag = true;
					tikas.append("\n1. MMR 1 </br>2. Varicella 1 </br>3.  PCV booster");
					
					break;
					
				case 456:
					flag = true;
					tikas.append("\n1. MMR 1 </br>2. Varicella 1 </br>3.  PCV booster");
					todayIsDueDate = false;
					break;
					
				case 486:
					flag = true;
					tikas.append("\n1. DTP B1 </br>2.  IPV B1 </br>3.  Hib B1");
					
					break;
					
				case 487:
					flag = true;
					tikas.append("\n1. DTP B1 </br>2.  IPV B1 </br>3.  Hib B1");
					todayIsDueDate = false;
					break;
					
				case 547:
					flag = true;
					tikas.append("\n1.  Hep-A 2 ");
					
					break;
					
				case 548:
					flag = true;
					tikas.append("\n1.  Hep-A 2");
					todayIsDueDate = false;
					break;
					
				case 729:
					flag = true;
					tikas.append("\n1.  Typhoid 1");
					
					break;
					
				case 730:
					flag = true;
					tikas.append("\n1.  Typhoid 1");
					todayIsDueDate = false;
					break;
					
				case 1642  :
					flag = true;
					tikas.append("\n1. DTP B2 </br>2. OPV 3 </br>3.  MMR 2 </br>4. Varicella 2 </br>5. Typhoid 2");
					
					break;
					
				case 1643:
					flag = true;
					tikas.append("\n1. DTP B2 </br>2. OPV 3 </br>3.  MMR 2 </br>4. Varicella 2 </br>5. Typhoid 2");
					todayIsDueDate = false;
					break;
					
				case 3651 :
					flag = true;
					tikas.append("\n1.Tdap/Td </br>2.  HPV ");
					
					break;
					
				case 3652:
					flag = true;
					tikas.append("\n1.Tdap/Td </br>2.  HPV ");
					todayIsDueDate = false;
					break;}
			
			//if call has to be made
			if(flag){
				
				Person p = OfyService.ofy().load().type(Person.class).id(c.parentMailId).get();
				if(!p.callAlert)
					continue;
				Integer callEntryCount = getCallRecordEntityCount();
				String parentId = p.email;
				String parentContact = p.mobile;
				String parentName = p.name;
				String callAlertDuration = p.callAlertDuration;
				

				String day ="";
				if(todayIsDueDate)
					day = "Today";
				else
					day = "Tomorrow";
				
				String description = "Hi <b>"+parentName+"</b>,"+day+" is the day to vaccinate your child <b>"+childName+"</b>. Please provide your child with following vaccinations:<hr />"+tikas.toString();
				
				try{
					CallRecordDao callEntry = new CallRecordDao(new  Long(callEntryCount+1), callAlertDuration, parentId, parentContact, parentName, description);
					ofy().save().entities(callEntry);
					ofy().clear();
				}catch(Exception err){
					err.printStackTrace();
				}
			}
		}
	}
}
