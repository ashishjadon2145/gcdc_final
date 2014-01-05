package com.osahub.hcs.vaccinate.util;

public class VacciBotUtil {
	public static String GetCategoryStringFromInt(int category) {
		if(category == 1)
			return "Greetings";
		else if (category == 2) 
			return "General questions";
		else if (category == 3) 
			return "Abusive";
		else if (category == 4) 
			return "Suggestions";
		else if (category == 5) 
			return "Feedback";
		else if (category == 6) 
			return "Adieu";
		else if (category == 7) 
			return "Queries about vacc. schedule";
		else if (category == 8) 
			return "Queries about next vaccine";
		else if (category == 9) 
			return "Queries how to do this and do that";
		else if (category == 10) 
			return "Queries how can i use schedular app";
		else if (category == 11) 
			return "Queries how can i use locator app";
		else if (category == 12) 
			return "Queries query about any particular vaccine";
		else if (category == 13) 
			return "Queries query about nearest vaccination center";
		else  
			return "";
	}
	public static String GetRoleStringFromInt(int category) {
		if(category == 1)
			return "Parent";
		else if (category == 2) 
			return "Volunteer";
		else if (category == 3) 
			return "Customer Care";
		else if (category == 4) 
			return "Administrator";
		else  
			return "User";
	}
}
