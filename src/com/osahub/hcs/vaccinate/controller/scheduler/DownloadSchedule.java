package com.osahub.hcs.vaccinate.controller.scheduler;

import java.io.OutputStream;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.joda.time.LocalDate;



public class DownloadSchedule extends HttpServlet {
	
	
	public String getFormattedDate(String tikkaDate){
		String formattedDate="";
		formattedDate = tikkaDate.substring(8, 10)+"/"+tikkaDate.substring(5, 7)+"/"+tikkaDate.substring(0, 4);
		return  formattedDate;
	}
	
	
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	{	
		
		
		String name = request.getParameter("childName");
		String dob = request.getParameter("dateOfBirth");
		
		LocalDate tikkaDate = new LocalDate(dob.substring(6,10)+"-"+dob.substring(0,2)+"-"+dob.substring(3,5));
		
				
		
			
			OutputStream out = null;
			  try
			  {
			   response.setContentType("application/vnd.ms-excel");
			   response.setHeader("Content-Disposition", "attachment; filename=vaccine_scheduler.xls");
			   WritableWorkbook w = Workbook.createWorkbook(response.getOutputStream());
			   WritableSheet s = w.createSheet("Demo", 0);
			  
			   WritableFont wf = new WritableFont(WritableFont.ARIAL,10);
			   WritableCellFormat cf = new WritableCellFormat(wf);
			   cf.setAlignment(Alignment.CENTRE);
			   cf.setVerticalAlignment(VerticalAlignment.CENTRE);
			   
			   
			   WritableFont upper2Rows = new WritableFont(WritableFont.TIMES, 10, WritableFont.BOLD);
			   WritableCellFormat cfUpper2Rows = new WritableCellFormat(upper2Rows);
			   cfUpper2Rows.setWrap(true);
			   cfUpper2Rows.setBackground(Colour.GRAY_25);
			   cfUpper2Rows.setAlignment(Alignment.CENTRE);
			   cfUpper2Rows.setVerticalAlignment(VerticalAlignment.CENTRE);
			   cfUpper2Rows.setBorder(Border.ALL, BorderLineStyle.MEDIUM_DASH_DOT,Colour.BLACK);
			   
			   WritableFont heading = new WritableFont(WritableFont.TIMES, 13, WritableFont.BOLD);
			   WritableCellFormat cfHeading= new WritableCellFormat(heading);
			   cfHeading.setWrap(true);
			   
			   cfHeading.setAlignment(Alignment.CENTRE);
			   cfHeading.setVerticalAlignment(VerticalAlignment.CENTRE);
			   cfHeading.setBorder(Border.ALL, BorderLineStyle.MEDIUM,Colour.BLACK);
			   
			   
			   cf.setWrap(true);
			   s.addCell(new Label(0, 0, "Child  Name" , cfUpper2Rows));
			   s.addCell(new Label(2, 0, name , cfUpper2Rows));
			   
			   
			   
			   
			   s.mergeCells(0, 0, 1, 0);
			   s.mergeCells(2, 0, 3, 0);
			   
			   s.addCell(new Label(0, 1, "Date of birth" , cfUpper2Rows));
			   s.addCell(new Label(2, 1, dob , cfUpper2Rows));
			   
			   s.mergeCells(0, 1, 1, 1);
			   s.mergeCells(2, 1, 3, 1);
			   
			   s.addCell(new Label(0, 2, "Age" , cfHeading));
			   s.addCell(new Label(1, 2, "Due date" , cfHeading));
			   s.addCell(new Label(2, 2, "Vaccine" , cfHeading));
			   s.addCell(new Label(3, 2, "Comments" , cfHeading));
			   
			   s.addCell(new Label(0, 3, "Birth" , cf));
			   s.addCell(new Label(1, 3, getFormattedDate(tikkaDate.toString()) , cf ));
			   s.addCell(new Label(2, 3, "B.C.G. \n Hep-B 1" , cf));
			   s.addCell(new Label(3, 3, "" , cf));
			   
			   s.addCell(new Label(0, 4, "6 weeks" , cf));
			   s.addCell(new Label(1, 4, getFormattedDate(tikkaDate.plusDays(42).toString()) ,cf ));
			   s.addCell(new Label(2, 4, "DTP 1 \n IPV 1 \n Hep-B 2 \n Hib 1 \n Rotavirus 1 \n PCV 1" , cf));
			   s.addCell(new Label(3, 4, "Polio : Use IPV. But may be replaced with OPV if former is unaffordable/unavailable \n Rotavirus : 2 doses of RV-1 and 3 doses of RV-5" , cf));
			   
			   s.addCell(new Label(0, 5, "10 weeks" , cf));
			   s.addCell(new Label(1, 5, getFormattedDate(tikkaDate.plusDays(70).toString()),cf  ));
			   s.addCell(new Label(2, 5, "DTP 2 \n IPV 2 \n Hib 2 \n Rotavirus 2 \n PCV 2" , cf));
			   s.addCell(new Label(3, 5, "" , cf));
			  
			   s.addCell(new Label(0, 6, "14 weeks" , cf));
			   s.addCell(new Label(1, 6, getFormattedDate(tikkaDate.plusDays(98).toString()) ,cf ));
			   s.addCell(new Label(2, 6, "DTP 3 \n IPV 3 \n Hib 3 \n Rotavirus 3 \n PCV 3" , cf));
			   s.addCell(new Label(3, 6, "Rotavirus : Only 2 doses of RV1 are recommended at present." , cf));
			  
			   s.addCell(new Label(0, 7, "14 weeks" , cf));
			   s.addCell(new Label(1, 7, getFormattedDate(tikkaDate.plusDays(98).toString()) ,cf  ));
			   s.addCell(new Label(2, 7, "DTP 3 \n IPV 3 \n Hib 3 \n Rotavirus 3 \n PCV 3" , cf));
			   s.addCell(new Label(3, 7, "Rotavirus : Only 2 doses of RV1 are recommended at present." , cf));
			  
			   s.addCell(new Label(0, 8, "6 months" , cf));
			   s.addCell(new Label(1, 8, getFormattedDate(tikkaDate.plusMonths(6).toString()) ,cf ));
			   s.addCell(new Label(2, 8, "OPV 1 \n Hep-B 3" , cf));
			   s.addCell(new Label(3, 8, "Hepatitis-B : The final (third or fourth) dose in the HepB vaccine series should be administered no earlier than age 24 weeks and at least 16 weeks after the first dose." , cf));
			   
			   s.addCell(new Label(0, 9, "9 months" , cf));
			   s.addCell(new Label(1, 9, getFormattedDate(tikkaDate.plusMonths(9).toString()) ,cf  ));
			   s.addCell(new Label(2, 9, "OPV 2 \n Measles" , cf));
			   s.addCell(new Label(3, 9, "" , cf));
			   
			   s.addCell(new Label(0, 10, "12 months" , cf));
			   s.addCell(new Label(1, 10, getFormattedDate(tikkaDate.plusMonths(12).toString()) , cf  ));
			   s.addCell(new Label(2, 10, "Hep-A 1" ,cf));
			   s.addCell(new Label(3, 10, "Hepatitis A : For both killed and live hepatitis-A vaccines, 2 doses are recommended" , cf));
			   
			   s.addCell(new Label(0, 11, "15 months" ,cf));
			   s.addCell(new Label(1, 11, getFormattedDate(tikkaDate.plusMonths(15).toString()) ,cf ));
			   s.addCell(new Label(2, 11, "MMR 1 \n Varicella 1 \n PCV booster" , cf));
			   s.addCell(new Label(3, 11, "Varicella : The risk of breakthrough varicella is lower if given 15 months onwards." , cf));
			  
			  
			   s.addCell(new Label(0, 12, "16-18 months" , cf));
			   s.addCell(new Label(1, 12, getFormattedDate(tikkaDate.plusMonths(16).toString()) , cf ));
			   s.addCell(new Label(2, 12, "DTP B1 \n IPV B1 \n Hib B1" , cf));
			   s.addCell(new Label(3, 12, "The first booster (4thth dose) may be administered as early as age 12 months, provided at least 6 months have elapsed since the third dose." , cf));
			  
			   s.addCell(new Label(0, 13, "18 months" , cf));
			   s.addCell(new Label(1, 13, getFormattedDate(tikkaDate.plusMonths(18).toString()) ,cf ));
			   s.addCell(new Label(2, 13, "Hep-A 2",cf));
			   s.addCell(new Label(3, 13, "Hepatitis A : For both killed and live hepatitis-A vaccines 2 doses are recommended",cf));
			  
			   s.addCell(new Label(0, 14, "2 years",cf));
			   s.addCell(new Label(1, 14, getFormattedDate(tikkaDate.plusYears(2).toString()),cf  ));
			   s.addCell(new Label(2, 14, "Typhoid 1",cf));
			   s.addCell(new Label(3, 14, "Typhoid : Typhoid revaccination every 3 years, if Vi-polysaccharide vaccine is used.",cf));
			   
			   s.addCell(new Label(0, 15, "4.5 - 5 years",cf));
			   s.addCell(new Label(1, 15, getFormattedDate(tikkaDate.plusMonths(54).toString()),cf  ));
			   s.addCell(new Label(2, 15, "DTP B2 \n OPV 3 \n MMR 2 \n Varicella 2 \n Typhoid 2" , cf));
			   s.addCell(new Label(3, 15, "MMR : the 2nd dose can be given at anytime 4-8 weeks after the 1st dose. \n Varicella : the 2nd dose can be given at anytime 3 months after the 1st dose." , cf));
			   
			   
			   s.addCell(new Label(0, 16, "10 - 12 years",cf));
			   s.addCell(new Label(1, 16, getFormattedDate(tikkaDate.plusYears(10).toString()),cf  ));
			   s.addCell(new Label(2, 16, "Tdap/Td \n HPV",cf));
			   s.addCell(new Label(3, 16, "Tdap : is preferred to Td followed by Td every 10 years. \n HPV : Only for females, 3 doses at 0, 1-2 (depending on brands) and 6 months." , cf));
			   
			   
			   s.setColumnView(0, 20);
			   s.setColumnView(1, 20);
			   s.setColumnView(2, 20);
			   s.setColumnView(3, 21);
			   
			   
			   w.write();
			   w.close();
			  } catch (Exception e)
			  {
			   System.out.println(e);
			  } 		
				
		
		
		
		}
	
	
	
	
	
	
}