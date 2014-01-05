package com.osahub.hcs.vaccinate.dao.registration;

import java.util.Date;

import org.joda.time.LocalDate;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;



@Entity
public class Child {
	
	@Parent
	public Key<com.osahub.hcs.vaccinate.dao.registration.Person> parent;
	@Id Long id;
	public String name;
	@Index public String parentMailId;
	public String dob; 
	public Date registrationDate;
	@Index public int ageInDays;
	
	//constructor for objectify
	public Child(){
	}
	
	//personalized generator
	public Child(Key<com.osahub.hcs.vaccinate.dao.registration.Person> pKey, String name, String parentMailId, String dob, int ageInDays) {
		super();
		this.parent = pKey;
		this.name = name;
		this.parentMailId = parentMailId;
		this.dob = dob;
		this.registrationDate = new Date();
		this.ageInDays = ageInDays;
	}
}
