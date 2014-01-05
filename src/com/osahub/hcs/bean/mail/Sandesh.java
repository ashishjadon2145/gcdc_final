package com.osahub.hcs.bean.mail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Sandesh {
	private final Message msg;
	
	/*
	 * This method returns the status of the mail being sent 
	 * */
	public boolean send(){
		try{
			Transport.send(this.msg);
			return true;
		}catch(Exception err){
			return false;
		}
	}
		
	public Sandesh(String recipient, String recipientName, String sender, String senderName, String subject, String mailBody) throws Exception{
		Properties props = new Properties();
		Session session1 = Session.getDefaultInstance(props, null);
		this.msg = new MimeMessage(session1);
		this.msg.setFrom(new InternetAddress(sender, senderName));
		this.msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient, recipientName));
		this.msg.setSubject(subject);
		this.msg.setText(mailBody);
	}
}
