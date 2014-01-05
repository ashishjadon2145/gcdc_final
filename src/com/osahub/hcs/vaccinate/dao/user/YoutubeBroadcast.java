package com.osahub.hcs.vaccinate.dao.user;
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
public class YoutubeBroadcast{


	@Id public String url ;
	 @Index public boolean isLive;
	public String createdBy;
	public String createdOn;
	public String description ;
		
	//default constructor for objectify
	public YoutubeBroadcast(){
		
	}
	
	//constructor
	public YoutubeBroadcast(String url, String createdBy, String createdOn, String description) {
		super();
		this.url  = url ;
		this.isLive = true ;
		this.createdBy = createdBy ;
		this.createdOn = createdOn ;
		this.description  = description ;
	}
}