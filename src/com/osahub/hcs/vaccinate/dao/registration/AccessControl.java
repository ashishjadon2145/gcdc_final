package com.osahub.hcs.vaccinate.dao.registration;


import java.util.Date;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class AccessControl{

	@Id		public String email  ;
	@Index	public int role;							//role = 1:parent; 2: vaccination center 3:helpline; 4:admin 5: freelancer 6: volunteer
	
	public String createdOn = "";
	@Index  public String createdBy = "";
	
	public String modifiedOn = "";
	@Index  public String modifiedBy = "";
	
	//default constructor for objectify
	public AccessControl(){
		
	}
	
	//constructor
	public AccessControl(String email, int role , String createdBy) {
		super();
		this.email = email;
		this.role = role;
		this.createdBy = createdBy;
		this.createdOn = new Date().toString();
	}
}