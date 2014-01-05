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
public class Vocabulary_old{

	/*
	 * Possible value for property type are
	 * 1  : Greetings eg. Hi, Hello, Hiya, good morning
	 * 2  : General questions eg. who are you, what u do
	 * 3  : Abusive 
	 * 4  : Suggestions (you shoud do this and that in this and that manner
	 * 5  : feedback : u r awesome, u r  a sucker
	 * 6  : Adieu eg. good bye, talk to you soon
	 * 7  : Queries about vacc. schedule
	 * 8  : Queries about next vaccine 
	 * 9  : Queries how to do this and do that 
	 * 10 : Queries how can i use schedular app
	 * 11 : Queries how can i use locator app 
	 * 12 : Queries query about any particular vaccine  
	 * 13 : Queries query about nearest vaccination center
	 * */
	@Index public long category ;
	@Id public String content;
	public boolean verified;
	public String createdBy;
	public Date createdOn;
	public String verifiedBy ;
	public Date verifiedOn;
		
	//default constructor for objectify
	public Vocabulary_old(){
		
	}
	
	//constructor
	public Vocabulary_old(int category, String content, String createdBy, Date createdOn) {
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
	public Vocabulary_old(int category, String content, String createdBy, Date createdOn, String verifiedBy, Date verifiedOn) {
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