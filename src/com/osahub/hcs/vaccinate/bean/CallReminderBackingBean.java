package com.osahub.hcs.vaccinate.bean;

import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.util.List;

import com.osahub.hcs.vaccinate.dao.user.CallRecordDao;

public class CallReminderBackingBean {
	
	public List<CallRecordDao> getAllCallsToBeMade(){
		 return ofy().load().type(CallRecordDao.class).filter("status", 1).list();
	}
	
	
}