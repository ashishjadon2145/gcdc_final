package com.osahub.hcs.vaccinate.dao.registration;


import com.google.appengine.api.blobstore.BlobKey;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Id;

import java.util.Date; 

@Entity
public class Person{

	//demographics fields
	@Id		public String email  ;
	@Index	public String mobile = "";
	public 	String	name;				
	public	String	addressLine1 = "";
	public	String	locality = "";
	public	String	district = "";
	public	String	city = "";
	public	String	state = "";
	public	int		country = 00;					//country = 91:India
	public	int		pin = 000000;
	public BlobKey image1 = null;
	
	//notification fields
	public int childCount = 0;	
	public Date mobileVerifyDate = null;	
	public Date emailVerifyDate = null;
	@Index public boolean emailVerified = true; // because registration is using google account only
	@Index public boolean mobileVerified = false;
	@Index public boolean smsAlert = true;
	@Index public boolean callAlert = true;
	public String callAlertDuration = "10am - 6pm";
	@Index public boolean emailAlert = true;
	@Index public boolean newsletter = true;
	
	//registration fields
	public Date registrationDate = null;
	public int registrationMode = 0;			//registrationMode = 1:online; 2:SMS; 3:call; 4:form
	public String registredBy = null;			//if registrationMode == 1 then registredBy = admin@tikakaran.com otherwise email-id of user who registered the person
	
	//donation fields
	public boolean isDonor = false;
	public int totalDonationAmount = 0;
	public String donorRef = null;
	public boolean showDonorRef = false;
	
	//login fields
	@Index public String userName = "";				// by default email id only but user can change it later once we launch our online store
	public String password = "";				// by default first 8 characters of the hash but user can change it later once we launch our online store
	public String lastLogin = "This is your first login!";
	public int role;							//role = 1:parent; 3:helpline; 4:admin 5:volunteer
	
	//other fields
	@Index  public String hash = "";
	
	//default constructor for objectify
	public Person(){
		
	}
	
	//constructor
	public Person(String email, Date registrationDate, int registrationMode, String registredBy, int role , String userName) {
		super();
		this.email = email;
		this.registrationDate = registrationDate;
		this.emailVerifyDate = registrationDate;
		this.registrationMode = registrationMode;
		this.registredBy = registredBy;
		this.role = role;
		this.name = email.substring(0, email.indexOf('@'));
		this.userName = userName;
	}
}