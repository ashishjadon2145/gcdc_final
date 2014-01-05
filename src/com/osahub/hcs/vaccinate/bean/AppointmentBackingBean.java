package com.osahub.hcs.vaccinate.bean;

import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.util.List;

import com.osahub.hcs.vaccinate.dao.user.AppointmentDao;

public class AppointmentBackingBean {
	
	public List<AppointmentDao> getAllAppointmentsByPatientId(String patientId){
		 return ofy().load().type(AppointmentDao.class).filter("patientId", patientId).list();
	}
	
	public List<AppointmentDao> getAllAppointmentsByVacciCenterId(String doctorId){
		 return ofy().load().type(AppointmentDao.class).filter("doctorId", doctorId).list();
	}
	
}