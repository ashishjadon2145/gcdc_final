package com.osahub.hcs.vaccinate.dao.vaccibot;
import java.util.ArrayList;
import java.util.Date;

import com.google.appengine.api.blobstore.BlobKey;
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
public class KnowledgeRepository{

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
	@Id public long category ;
	public String description;
	@Index public int docCount = 1;
	@Index public double priorProbability = 0.142857;
	public int hitCount = 0;
		
	//default constructor for objectify
	public KnowledgeRepository(){
		
	}
	
	//constructor
	public KnowledgeRepository(int category, String description) {
		super();
		this.category = category;
		this.description = description;
	}
}