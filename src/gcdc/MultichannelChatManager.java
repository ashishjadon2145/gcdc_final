package gcdc;

import java.util.HashSet;
import java.util.Iterator;
import com.google.appengine.api.channel.ChannelMessage;
import com.google.appengine.api.channel.ChannelService;
import com.google.appengine.api.channel.ChannelServiceFactory;

public class MultichannelChatManager {
	private static HashSet<String> subs = new HashSet<String>();
	
	//Check subscription
	public static boolean isSubscribed(String sub) {
		return subs.contains(sub);
	}
	
	//Remove subscription
	public static void removeSub(String sub) {
		subs.remove(sub);
	}
	
	//Add a new subscription
	public static void addSub(String sub) {
		subs.add(sub);
	}

	// Send out a given message to all subscribers and clients
	public static void sendMessage(String body, String source) {
		Iterator<String> it = subs.iterator();
		while (it.hasNext()) {
			String sub = it.next();
			String messageBody = source + ": " + body;

			// Otherwise, it's a browser-based client
			
				ChannelService channelService = ChannelServiceFactory.getChannelService();
				channelService.sendMessage(new ChannelMessage(sub,messageBody));
			
		}
	}
}
