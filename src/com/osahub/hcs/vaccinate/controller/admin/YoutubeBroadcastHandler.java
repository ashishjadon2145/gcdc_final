package com.osahub.hcs.vaccinate.controller.admin;

import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.QueryResultIterator;
import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;
import com.osahub.hcs.vaccinate.controller.vaccinate.VaccibotClassify;
import com.osahub.hcs.vaccinate.dao.user.YoutubeBroadcast;
import com.osahub.hcs.vaccinate.dao.user.YoutubeBroadcastChannelQueries;
import com.osahub.hcs.vaccinate.dao.vaccibot.Vocabulary;

public class YoutubeBroadcastHandler extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{

		if (request.getParameter("action").trim().equalsIgnoreCase("start")) {
			String url = request.getParameter("url").toString();
			String description = request.getParameter("description").toString();
			try{
				YoutubeBroadcast session = new YoutubeBroadcast(url,"admin@osahub.com",new Date().toString(),description);
				ofy().save().entities(session);
				ofy().clear();
			}catch(Exception dd){
				response.sendRedirect("/adminPanel?status=100#youtube_broadcast");
			}
			response.sendRedirect("/adminPanel?status=101#youtube_broadcast");
		}

		else if (request.getParameter("action").trim().equals("stop")) {
				QueryResultIterator<YoutubeBroadcast> liveSessionIterator = OfyService.ofy().load().type(YoutubeBroadcast.class).filter("isLive",true).iterator();
				if( liveSessionIterator != null){
					while(liveSessionIterator.hasNext()){
						YoutubeBroadcast liveSession = liveSessionIterator.next();
						liveSession.isLive =false;
						ofy().save().entities(liveSession);
						ofy().clear();
					}
				}
			response.sendRedirect("adminPanel?status=102#youtube_broadcast");
		}

		else if (request.getParameter("action").trim().equals("channelApiDatstoreSave")) {
			String userId = (request.getParameter("userid"));
			String query = (request.getParameter("message"));
			//String createdBy = (request.getParameter("createdBy"));
			String createdBy = "admin@osahub.com";
			YoutubeBroadcastChannelQueries userQuery = new YoutubeBroadcastChannelQueries(userId, createdBy, new Date().toString(), query);
			ofy().save().entities(userQuery);
			ofy().clear();
		}
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException{}
	
	public static String getLiveStream(){
		QueryResultIterator<YoutubeBroadcast> liveSessionIterator = OfyService.ofy().load().type(YoutubeBroadcast.class).filter("isLive",true).iterator();
		if( liveSessionIterator != null){
			while(liveSessionIterator.hasNext()){
				YoutubeBroadcast liveSession = liveSessionIterator.next();
				return liveSession.url;
			}
			return " ";
		}
		else 
			return " ";
	}
}