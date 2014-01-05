package com.osahub.hcs.vaccinate.dao.vaccibot;
import java.util.ArrayList;
import java.util.Date;

import com.google.appengine.api.blobstore.BlobKey;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.osahub.hcs.vaccinate.bean.VaccinePrice;

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
public class VaccineRepository{
	@Id public String productCode ;
	
	/*
	 * Possible value for property type are
	 * 1 : Sarees
	 * 2 : Lehenga
	 * 3 : Suits
	 * 4 : Anarkali
	 * 5 : Kurtis
	 */
	
	@Index public String category;
	public String name;
	@Index public String description;
	@Index public ArrayList<VaccinePrice> AveragePrivateCost;
	@Index public ArrayList<VaccinePrice>  AverageGovtCost;
	public int stockAvailable;
	public Date createdOn;
	public String createdBy;
	
	public Boolean outOfStock = false;
	@Index public Boolean showOnWebsite = true;
	public BlobKey image1 = null;
	public BlobKey image2 = null;
	public Date updatedOn = null;
	public String updatedBy = null;
	

	public int hitCount=0;
		
	//default constructor for objectify
	public VaccineRepository(){
		
	}
	
	//constructor
	public VaccineRepository(String productCode, BlobKey image1, String category, String name, String description, Long mrp, int stockAvailable, String createdBy) {
		super();
		this.productCode = productCode;
		this.category = category;
		this.name = name;
		this.description = description;
		this.stockAvailable = stockAvailable;
		this.createdBy = createdBy;
		this.createdOn = new Date();
		this.image1 = image1;
	}
}