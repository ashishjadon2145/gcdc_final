package com.osahub.hcs.vaccinate.controller.vaccinate;


import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.xmpp.Message;
import com.google.appengine.api.xmpp.MessageBuilder;
import com.google.appengine.api.xmpp.MessageType;
import com.google.appengine.api.xmpp.XMPPService;
import com.google.appengine.api.xmpp.XMPPServiceFactory;
import com.osahub.hcs.vaccinate.bean.Smarty;

public class VaccibotClassify_old extends HttpServlet {
	//declaring and initialize with blank string
	public static String[] vocab = {"","","","","","","","","","","","",""}; 
	public static double[] priorProbability = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0}; 
	private static final XMPPService xmppService = XMPPServiceFactory.getXMPPService();

	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Message message = xmppService.parseMessage(request);
		System.out.println("\n\n\n\n\n\n\nn\n\n\n xmpp message:"+message+"\n\n\n\n\n\n\nn\n\n\n");
		Smarty smarty = new Smarty(); 

		Message reply = new MessageBuilder().withRecipientJids(message.getFromJid()).withMessageType(MessageType.NORMAL).withBody(smarty.getAnswer(message.getBody())).build();
		xmppService.sendMessage(reply);
	}

	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
	}
	
}