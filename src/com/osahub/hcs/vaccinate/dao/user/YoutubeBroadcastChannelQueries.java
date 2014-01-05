package com.osahub.hcs.vaccinate.dao.user;
import java.util.Date;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;


@Entity
public class YoutubeBroadcastChannelQueries{


	@Id public String createdOn ;
	@Index public boolean isLive;
	@Index public String createdBy;
	@Index public String userId;
	public String query ;
		
	//default constructor for objectify
	public YoutubeBroadcastChannelQueries(){
		
	}
	
	//constructor
	public YoutubeBroadcastChannelQueries(String userId, String createdBy, String createdOn, String query) {
		super();
		this.userId  = userId ;
		this.isLive = true ;
		this.createdBy = createdBy ;
		this.createdOn = createdOn ;
		this.query  = query ;
	}
}