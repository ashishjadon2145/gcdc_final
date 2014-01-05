package com.osahub.hcs.vaccinate.dao.vaccibot;
import java.util.Date;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

/* 
 * Create() may be called in different services depending upon number of constructor.
 * Read() may be called in different services depending upon number of properties which are indexed.
 * Update() & Delete() will be called only once from one place.
 *
 * Method		Service Id
 * C reate	:	1001
 * U pdate	:
 * R ead	:	By productCode : 1001, By category & showOnWebsite : 1002, By description = 1001
 * D elete	:
 * */

@Entity
public class Vocabulary{

	/*
	 * Possible value for property type are
	 * 1  : Greetings	: Hi, Hello, Hiya, good morning , good night, bye, cya
	 * 2  : General		: who are you, what u do
	 * 3  : Abusive 
	 * 4  : Feedback	: Suggestions & Feedback
	 * 5  : Scheduler	: Queries about vacc. schedule, next vaccine, schedular app
	 * 6  :	Vaccine		: Queries query about any particular vaccine
	 * 7  : Locator		: Queries how can i use locator app, nearest vaccination center
	 * 8  : Unknown
	 * */
	@Index public long category ;
	@Id public String content;
	public boolean verified;
	public String createdBy;
	public Date createdOn;
	public String verifiedBy ;
	public Date verifiedOn;
		
	//default constructor for objectify
	public Vocabulary(){
		
	}
	
	//constructor
	public Vocabulary(int category, String content, String createdBy, Date createdOn) {
		super();
		this.category = category;
		this.content = content;
		this.verified = false;
		this.createdBy = createdBy;
		this.createdOn = createdOn;
		this.verifiedBy = null;
		this.verifiedOn = null;
	}
	
	//constructor
	public Vocabulary(int category, String content, String createdBy, Date createdOn, String verifiedBy, Date verifiedOn) {
		super();
		this.category = category;
		this.content = content;
		this.verified = true;
		this.createdBy = createdBy;
		this.createdOn = createdOn;
		this.verifiedBy = verifiedBy;
		this.verifiedOn = verifiedOn;
	}
}