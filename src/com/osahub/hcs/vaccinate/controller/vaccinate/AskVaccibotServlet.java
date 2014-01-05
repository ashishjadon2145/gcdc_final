package com.osahub.hcs.vaccinate.controller.vaccinate;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.osahub.hcs.vaccinate.bean.Smarty;

public class AskVaccibotServlet extends HttpServlet {

	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("in action");
		String question = request.getParameter("message");

		Smarty smarty = new Smarty();

		String answer = smarty.getAnswer(question);
		
		response.getWriter().print(answer);
	 }
}
