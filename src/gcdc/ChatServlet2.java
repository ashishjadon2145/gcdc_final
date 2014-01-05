package gcdc;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.channel.ChannelService;
import com.google.appengine.api.channel.ChannelServiceFactory;

@SuppressWarnings("serial")
public class ChatServlet2 extends HttpServlet {
        //Generate a client token for the GAE Channel API
        public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {

        	//String chatSource  = req.getParameter("chatSourceIdentifier");
        	//if(chatSource!=null && chatSource.equalsIgnoreCase("liveConsult")) {
            	//System.out.println("in sclass chatservlet dogetmethod()");
                MultichannelChatManager.sendMessage(req.getParameter("message"), req.getParameter("chatUserId"));
                res.setContentType("text/plain");
                res.getWriter().print("yep.");
        	/*}
        	else if(chatSource!=null &&  chatSource.equalsIgnoreCase("parentZone")) {
            	//System.out.println("in sclass chatservlet dogetmethod()");
                MultichannelChatManager.sendMessage(req.getParameter("message"), req.getParameter("chatUserId"),chatSource);
                res.setContentType("text/plain");
                res.getWriter().print("yep.");
        	}*/
        }

        //Publish a chat message to all subscribers, if this subscriber exists
        /*public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
                MultichannelChatManager.sendMessage(req.getParameter("message"), req.getParameter("chatUserId"));
                res.setContentType("text/plain");
                res.getWriter().print("yep.");
        }*/
}