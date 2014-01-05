package com.osahub.hcs.vaccinate.bean;

import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;
import com.osahub.hcs.bean.mail.Sandesh;
import com.osahub.hcs.vaccinate.dao.registration.Child;
import com.osahub.hcs.vaccinate.dao.registration.Person;


/////////This class is to send mail every day 
public class Postman extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		//Send mails here
		
		//List<MergeVars> batch = new ArrayList<MergeVars>();
		
		//
		StringBuffer tikas = new StringBuffer();
		
		
		
		//First get the list of the child's
		//Should we get all the child's 
		List<Child> children = ofy().load().type(Child.class).list();
		
		 
		for(Child c : children){
			boolean flag = false;
			boolean todayIsDueDate = true;
			//System.out.println(c.ageInDays);
			String childName = c.name;
			int ageInDays = c.ageInDays++;
	        OfyService.ofy().save().entities(c);
	        OfyService.ofy().clear();
	        
	        //String vac1 = null;
			//String vac2 = null;
			//String when = "Today";
			
			switch(ageInDays){
				case 1:
					flag = true;
					tikas.append("\n\n1. B.C.G. (injection) "+
							 	"\n\n2. Hep-B 1");
					//vac1 =  "B.C.G. (injection)";
					break;
					
				
					
				case 41:
					flag = true;
					tikas.append("\n\n1. DTP 1 "+
								 "\n\n2.  IPV 1"+
								 "\n\n2. Hep-B 2"+
								 "\n\n3. Hib 1"+
								 "\n\n4. Rotavirus 1"+
								 "\n\n5. PCV 1");
					
					break;
					
				case 42:
					flag = true;
					tikas.append("\n\n1. DTP 1 "+
								 "\n\n2.  IPV 1"+
								 "\n\n2. Hep-B 2"+
								 "\n\n3. Hib 1"+
								 "\n\n4. Rotavirus 1"+
								 "\n\n5. PCV 1");
					todayIsDueDate = false;
					break;
					
					
				case 69:
					flag = true;
					tikas.append("\n\n1. DTP 2 "+
							     "\n\n2.  IPV 2"+
								 "\n\n3. Hib 2"+
								 "\n\n4. Rotavirus 2"+
								 "\n\n5. PCV 2");
					
					break;
					
				case 70:
					flag = true;
					tikas.append("\n\n1. DTP 2 "+
							     "\n\n2.  IPV 2"+
								 "\n\n3. Hib 2"+
								 "\n\n4. Rotavirus 2"+
								 "\n\n5. PCV 2");
					todayIsDueDate = false;
					break;
					
				case 97:
					flag = true;
					tikas.append("\n\n1. DTP 3 "+
							     "\n\n2.  IPV 3"+
								 "\n\n3. Hib 3"+
								 "\n\n4. Rotavirus 3"+
								 "\n\n5. PCV 3");
					
					break;
					
				case 98:
					flag = true;
					tikas.append("\n\n1. DTP 3 "+
							     "\n\n2.  IPV 3"+
								 "\n\n3. Hib 3"+
								 "\n\n4. Rotavirus 3"+
								 "\n\n5. PCV 3");
					todayIsDueDate = false;
					break;
					
				case 181:
					flag = true;
					tikas.append("\n\n1. OPV 1 "+
								 "\n\n2.  Hep-B 3");
					
					break;
					
				case 182:
					flag = true;
					tikas.append("\n\n1. OPV 1 "+
								 "\n\n2.  Hep-B 3");
					todayIsDueDate = false;
					break;
					
				case 272:
					flag = true;
					tikas.append("\n\n1. OPV 2 "+
								 "\n\n2. Measles");
					
					break;
					
				case 273:
					flag = true;
					tikas.append("\n\n1. OPV 2 "+
								 "\n\n2. Measles");
					todayIsDueDate = false;
					break;
					
				case 364:
					flag = true;
					tikas.append("\n\n1.Hep-A 1");
					
					break;
					
				case 365:
					flag = true;
					tikas.append("\n\n1.Hep-A 1");
					todayIsDueDate = false;
					break;
					
				case 455:
					flag = true;
					tikas.append("\n\n1. MMR 1 "+
								 "\n\n2. Varicella 1"+
								 "\n\n3.  PCV booster");
					
					break;
					
				case 456:
					flag = true;
					tikas.append("\n\n1. MMR 1 "+
								 "\n\n2. Varicella 1"+
								 "\n\n3.  PCV booster");
					todayIsDueDate = false;
					break;
					
				case 486:
					flag = true;
					tikas.append("\n\n1. DTP B1 "+
								 "\n\n2.  IPV B1"+
								 "\n\n3.  Hib B1");
					
					break;
					
				case 487:
					flag = true;
					tikas.append("\n\n1. DTP B1 "+
								 "\n\n2.  IPV B1"+
								 "\n\n3.  Hib B1");
					todayIsDueDate = false;
					break;
					
				case 547:
					flag = true;
					tikas.append("\n\n1.  Hep-A 2 ");
					
					break;
					
				case 548:
					flag = true;
					tikas.append("\n\n1.  Hep-A 2");
					todayIsDueDate = false;
					break;
					
				case 729:
					flag = true;
					tikas.append("\n\n1.  Typhoid 1");
					
					break;
					
				case 730:
					flag = true;
					tikas.append("\n\n1.  Typhoid 1");
					todayIsDueDate = false;
					break;
					
				case 1642  :
					flag = true;
					tikas.append("\n\n1. DTP B2 "+
								 "\n\n2. OPV 3"+
								 "\n\n3.  MMR 2"+
								 "\n\n4. Varicella 2"+
								 "\n\n5. Typhoid 2");
					
					break;
					
				case 1643:
					flag = true;
					tikas.append("\n\n1. DTP B2 "+
								 "\n\n2. OPV 3"+
								 "\n\n3.  MMR 2"+
								 "\n\n4. Varicella 2"+
								 "\n\n5. Typhoid 2");
					todayIsDueDate = false;
					break;
					
				case 3651 :
					flag = true;
					tikas.append("\n\n1.Tdap/Td "+
								 "\n\n2.  HPV ");
					
					break;
					
				case 3652:
					flag = true;
					tikas.append("\n\n1.Tdap/Td "+
								 "\n\n2.  HPV ");
					todayIsDueDate = false;
					break;}
			
			//if mail has to be sent
			if(flag){
				
				Person p = ofy().load().key(c.parent).get();
				if(!p.emailAlert)
					continue;
				String name = p.name;
				String email = p.email;
				
				//get the date
				/*Calendar cal = Calendar.getInstance();
				String date = null;
				if(when.equalsIgnoreCase("Today")){
					int day = cal.get(Calendar.DAY_OF_MONTH);
					int month = cal.get(Calendar.MONTH)+1;
					int year = cal.get(Calendar.YEAR);
					date = day +"/"+month+"/"+year;
				}
				else{
					int day = cal.get(Calendar.DAY_OF_MONTH)+1;
					int month = cal.get(Calendar.MONTH)+1;
					int year = cal.get(Calendar.YEAR);
					date = day +"/"+month+"/"+year;					
				}
				
				MergeVars sonsOfGuns = null;
				if(vac2 != null)
					if(vac3 !=null)
						sonsOfGuns = new MergeVars(email, name,when,date,vac1, vac2,vac3,c.name);
					else
						sonsOfGuns = new MergeVars(email, name,when,date,vac1, vac2,c.name);
				else
					sonsOfGuns = new MergeVars(email, name,when,date,vac1,c.name);
				
				batch.add(sonsOfGuns);*/
				//sonsOfGuns = null;
				String day ="";
				if(todayIsDueDate)
					day = "Today";
				else
					day = "Tomorrow";
				
				String mailMessage = "Hi "+name+", \n\n\n "+day+" is the day to vaccinate your child "+childName+". \n\n\nPlease provide your child with following vaccinations:<hr />"+tikas.toString()+
				"\n\nThanks and Regards \nTeam Vaccinate\n";
				
				try{
					Sandesh reminderMail = new Sandesh(email, name, "sio.dreamweaver@gmail.com", "Team Vaccinate", "Vaccination reminder for your child "+childName+" .", mailMessage);
					reminderMail.send();
				}catch(Exception err){
					err.printStackTrace();
				}
			}
		}/*
		//create the mail chimp object
		MailChimpClient mailChimpClient = new MailChimpClient(new JavaNetURLConnectionManager());
		
		//first delete all the members from the list
		//getting the members list
		ListMembersMethod oldList = new ListMembersMethod();
		oldList.apikey = "e69d915d1c80780accde25bd045b2a66-us6";
		oldList.id = "d61141f957";
		try {
			ListMembersResult res = mailChimpClient.execute(oldList);
			ArrayList<String> email = new ArrayList<String>();
			for(ShortMemberInfo s: res.data){
				email.add(s.email);
				//System.out.println("this email unsbscribe"+s.email);
			}
			
			//deleting the members
			ListBatchUnsubscribeMethod del =  new ListBatchUnsubscribeMethod();
			del.apikey = "e69d915d1c80780accde25bd045b2a66-us6";
			del.id ="d61141f957";
			del.emails = email;
			del.send_goodbye = false;
			del.delete_member = true;
			del.send_notify = false;
			mailChimpClient.execute(del);
			
		} catch (MailChimpException e) {
			// TODO Auto-generated catch block
			//System.out.println("error in postman:257");
			e.printStackTrace();
		}

		//now add the emails to the list
		ListBatchSubscribeMethod lister  = new ListBatchSubscribeMethod();
		
		
		lister.apikey = "e69d915d1c80780accde25bd045b2a66-us6";
		lister.double_optin = false;
		lister.id = "d61141f957";
		lister.update_existing = true;
		lister.batch = batch;
		
		
	  //now send the campaign
		CampaignSendNowMethod send = new CampaignSendNowMethod();
		send.cid = "2312f15b95";
		send.apikey = "e69d915d1c80780accde25bd045b2a66-us6";
		
		
		
		try {
			mailChimpClient.execute(lister);
			mailChimpClient.execute(send);
		} catch (MailChimpException e) {
			// TODO Auto-generated catch block
			//System.out.println("error in postman:241");
			e.printStackTrace();
		}
	*/
	}
}
