package com.osahub.hcs.vaccinate.dao.user;
import java.util.Date;

import com.google.appengine.api.blobstore.BlobKey;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class AppointmentDao{
	@Id public Long appointmentId ;
	//patient email id
	@Index public String patientId ;
	@Index public String patientContact ;
	@Index public String patientName ;
	
	@Index public String appointmentDate ;
	/*
	 * Possible value for property type are
	 * 1 : Open
	 * 2 : Accepted
	 * 3 : Rejected
	 * 4 : Closed
	 * */
	@Index public int status;
	/*
	 * Possible value for property type are
	 * 1 : Home Immunization
	 * */
	@Index public int category;
	@Index public String doctorId;
	@Index public String doctorName;
	@Index public String doctorContact;
	@Index public String description;
	public Date createdOn;
	public String createdBy;
	public BlobKey attachment1 = null;
	public BlobKey attachment2 = null;
	public String notes = null;

	//default constructor for objectify
	public AppointmentDao(){
		
	}
	
	//constructor
	public AppointmentDao(Long appointmentId, int status, String patientId, String patientContact, String patientName, String appointmentDate, int category, String doctorId, String doctorName, String doctorContact, String description, String createdBy, String notes) {
		super();
		this.appointmentId = appointmentId;
		this.status = status;
		this.patientId = patientId;
		this.patientContact = patientContact;
		this.patientName=patientName;
		this.appointmentDate = appointmentDate;
		this.category = category;
		this.doctorId = doctorId;
		this.doctorName = doctorName ;
		this.doctorContact = doctorContact ;
		this.description = description;
		this.createdBy = createdBy;
		this.createdOn = new Date();
		this.notes = notes;
	}
}