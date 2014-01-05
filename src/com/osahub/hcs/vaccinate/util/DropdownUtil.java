package com.osahub.hcs.vaccinate.util;

public class DropdownUtil {
	public static String GetCategoryStringFromInt(int category) {
		if(category == 1)
			return "Greetings";
		else if (category == 2) 
			return "General";
		else if (category == 3) 
			return "Abusive";
		else if (category == 4) 
			return "Feedback";
		else if (category == 5) 
			return "Scheduler";
		else if (category == 6) 
			return "Vaccine";
		else if (category == 7) 
			return "Locator";
		else  
			return "Unknown";
	}
	
	public static String GetRoleStringFromInt(int category) {
		if(category == 1)
			return "Parent";
		else if (category == 2) 
			return "Hospital";
		else if (category == 3) 
			return "Helpline";
		else if (category == 4) 
			return "Administrator";
		else  
			return "User";
	}
	
	public static String getSessionPropertyNameFromActionSource(String actionSource) {
		if(actionSource.equalsIgnoreCase("parent"))
			return "userId";
		if(actionSource.equalsIgnoreCase("hospital"))
			return "hospitalEmailId";
		if(actionSource.equalsIgnoreCase("freelancer"))
			return "freelancerId";
		if(actionSource.equalsIgnoreCase("admin"))
			return "adminId";
		if(actionSource.equalsIgnoreCase("volunteer"))
			return "volunteerId";
		if(actionSource.equalsIgnoreCase("helpline"))
			return "helplineID";
		else
			return null;
	}
	
	public static String GetVaccinationCenterTypeStringFromInt(int category) {
		if(category == 1)
			return "Govt. Hospital";
		else if (category == 2) 
			return "Charitable Hospital";
		else if (category == 3) 
			return "NGO";
		else if (category == 4) 
			return "Private Hospital";
		else if (category == 5) 
			return "Private Clinic";
		else if (category == 6) 
			return "Freelancer";
		else  
			return "";
	}
	
	public static String GetCallStatusStringFromInt(int category) {
		if(category == 1)
			return "Open";
		else if (category == 2) 
			return "Not Answered";
		else if (category == 3) 
			return "Not Reachable";
		else if (category == 4) 
			return "Wrong Number";
		else if (category == 5) 
			return "Rejected";
		else if (category == 5) 
			return "Closed";
		else  
			return "NA";
	}
	
	public static String GetAppointmentStatusStringFromInt(int category) {
		if(category == 1)
			return "Open";
		else if (category == 2) 
			return "Accepted";
		else if (category == 3) 
			return "Rejected";
		else if (category == 4) 
			return "Closed";
		else  
			return "NA";
	}
	
	public static String GetCenterTypeStringFromInt(int category) {
		if(category == 1)
			return "Gov.t Hospital";
		else if (category == 2) 
			return "Charitable Hospital";
		else if (category == 3) 
			return "NGO";
		else if (category == 4) 
			return "Private Hospital";
		else if (category == 5) 
			return "Private Clinic";
		else  
			return "User";
	}
	
	public static String GetHomeVaccinationRangeStringFromInt(int category) {
		if(category == 1)
			return "Locality (1-5 Km)";
		else if (category == 2) 
			return "District (5-25 Km)";
		else if (category == 3) 
			return "City  (25-100 Km)";
		else if (category == 4) 
			return "State";
		else if (category == 5) 
			return "Country";
		else  
			return "";
	}
	
	public static String GetWeekDayStringFromInt(int day) {
		if(day == 1)
			return "Monday";
		else if (day == 2) 
			return "Tuesday";
		else if (day == 3) 
			return "Wednesday";
		else if (day == 4) 
			return "Thursday";
		else if (day == 5) 
			return "Friday";
		else if (day == 6) 
			return "Saturday";
		else if (day == 6) 
			return "Sunday";
		else  
			return "All Days Open";
	}
}
