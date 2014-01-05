package com.osahub.hcs.vaccinate.dao.user;
import java.util.Date;

import com.google.appengine.api.blobstore.BlobKey;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class CallRecordDao{
	@Id public Long callId ;
	//parent email id
	@Index public String parentId ;
	@Index public String parentContact ;
	@Index public String parentName ;

	public String callAlertDuration;
	
	@Index public String callDate ;
	/*
	 * Possible value for property type are
	 * 1 : Open
	 * 2 : Not Answered
	 * 3 : Not Reachable
	 * 4 : Wrong Number
	 * 5 : Rejected
	 * 6 : Closed
	 * */
	@Index public int status;
	/*
	 * Possible value for property type are
	 * 1 : Inbound Call
	 * 2 : Outbound Call
	 * */
	@Index public int type;
	/*
	 * Possible value for property type are
	 * 1 : Vaccination Reminder Call
	 * */
	@Index public int category;
	@Index public String description;
	public Date createdOn;
	public String createdBy;
	public BlobKey attachment1 = null;
	public BlobKey attachment2 = null;
	public String notes = null;

	//default constructor for objectify
	public CallRecordDao(){
		
	}
	
	//constructor
	public CallRecordDao(Long callId, int status, String callAlertDuration, String parentId, String parentContact, String parentName, String callDate, int type, int category, String description, String createdBy, String notes) {
		super();
		this.callId = callId;
		this.callAlertDuration = callAlertDuration;
		this.status = status;
		this.parentId = parentId;
		this.parentContact = parentContact;
		this.parentName=parentName;
		this.callDate = callDate;
		this.type = type;
		this.category = category;
		this.description = description;
		this.createdBy = createdBy;
		this.createdOn = new Date();
		this.notes = notes;
	}
	
	//constructor
	public CallRecordDao(Long callId, String callAlertDuration, String parentId, String parentContact, String parentName, String description) {
		super();
		this.callId = callId;
		this.status = 1;
		this.callAlertDuration = callAlertDuration;
		this.parentId = parentId;
		this.parentContact = parentContact;
		this.parentName=parentName;
		this.callDate = new Date().toString();
		this.type = 2;
		this.category = 1;
		this.description = description;
		this.createdBy = "BackendJobs";
		this.createdOn = new Date();
		this.notes = "";
	}
}