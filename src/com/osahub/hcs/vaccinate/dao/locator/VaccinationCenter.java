package com.osahub.hcs.vaccinate.dao.locator;

import java.util.Date;

import com.google.appengine.api.blobstore.BlobKey;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class VaccinationCenter {

	//could be email(if registered online), hospital name otherwise
	@Id
	public String id;
	
	@Index
	public String name;
	public String aboutMe="";
	public double xCor;
	public double yCor;
	public String add1;
	@Index
	public	String	locality = "";
	@Index
	public	String	district = "";
	@Index
	public	String	city = "";
	@Index
	public	String	state = "";
	@Index
	public	int		country = 00;	
	@Index				
	public	int		pincode = 000000;
	
	public String contact1;
	public String contact2="";
	public String fax="";
	public String website;
	@Index
	public String email;
	@Index
	public String workingHours;
	@Index
	public int weaklyHoliday=0;
	@Index
	public String facilities;
	@Index
	public boolean homeVaccinationAvailable = false;

	/*
	 * Possible value for property homeVaccinationRange are
	 * 1 : Locality (1-2 Km) 
	 * 2 : District (5-10 Km) 
	 * 3 : City 
	 * 4 : State 
	 * 5 : Country
	 * 6 : World Wide
	 */
	@Index
	public int homeVaccinationRange = 0;

	/*
	 * Possible value for property are
	 * 1 : Not Reviwed 
	 * 2 : Reviwed and Accepted 
	 * 3 : Reviwed and Rejected 
	 */
	@Index
	public int isVerified;
	public String verifiedComment;
	@Index
	public String verifiedBy;
	@Index
	public String verifiedOn;
	@Index
	public boolean hasMapCordinate;
	public BlobKey image1 = null;
	//public BlobKey document1 = null;
	@Index
	public float rating;
	@Index
	public int reputation;
	// who added this center or by whose refrence it ws added or mode of
	// registration
	@Index
	public String refrence;
	public String lastLogin = "This is your first login!";
	public String createdOn;

	/*
	 * Possible value for property type are
	 * 1 : Govt. Hospital 
	 * 2 : Charitable Hospital 
	 * 3 : NGO 
	 * 4 : Private Hospital 
	 * 5 : Private Clinic
	 */
	@Index
	public int type = 0;

	public VaccinationCenter() {

	}

	public VaccinationCenter(String name, int pincode, double xCor, double yCor, String contact1, String add1, String workingHours, String refrence) {
		this.id = name;
		this.name = name;
		this.pincode = pincode;
		this.xCor = xCor;
		this.yCor = yCor;
		this.contact1 = contact1;
		this.add1 = add1;
		this.workingHours = workingHours;
		this.isVerified = 1;
		this.hasMapCordinate = true;
		this.refrence = refrence;
		this.createdOn = new Date().toString();
	}

	public VaccinationCenter(String email) {
		this.id = email;
		this.email = email;
		this.name = "";
		this.pincode = 000000;
		this.xCor = 0.0d;
		this.yCor = 0.0d;
		this.contact1 = "";
		this.add1 = "";
		this.workingHours = "";
		this.isVerified = 1;
		this.hasMapCordinate = false;
		this.refrence = "ONLINE";
		this.createdOn = new Date().toString();
	}
}
