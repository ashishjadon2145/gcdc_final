package com.osahub.hcs.vaccinate.bean;

import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.util.List;

import com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter;

public class ApproveVaccinationCenterBackingBean {
	
	public List<VaccinationCenter> getAllCentersToBeApproved(){
		 return ofy().load().type(VaccinationCenter.class).filter("isVerified", 1).list();
	}
}