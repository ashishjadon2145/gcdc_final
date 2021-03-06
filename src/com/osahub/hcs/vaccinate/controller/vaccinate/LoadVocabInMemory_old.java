package com.osahub.hcs.vaccinate.controller.vaccinate;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.QueryResultIterator;
import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;
import com.osahub.hcs.vaccinate.dao.vaccibot.KnowledgeRepository;
import com.osahub.hcs.vaccinate.dao.vaccibot.Vocabulary;
import com.osahub.hcs.vaccinate.util.DropdownUtil;

public class LoadVocabInMemory_old extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		if(req.getParameter("action").trim().equalsIgnoreCase("loadVocabInMemory")){
			for(int i=1; i<14; i++){
				QueryResultIterator<Vocabulary> vocabIterator = OfyService.ofy().load().type(Vocabulary.class).filter("category",i).iterator();
				if( vocabIterator != null){
					while(vocabIterator.hasNext()){
						Vocabulary vocab = vocabIterator.next();
						VaccibotClassify.vocab[i-1] = VaccibotClassify.vocab[i-1]+" "+vocab.content;
					}
				}
			}
			resp.sendRedirect("/admin?status=786");
		}
		
		else if(req.getParameter("action").trim().equals("calculatePriorProb")){
			VaccibotLearn.updatePriorProbabilities();
		}
		
		else if(req.getParameter("action").trim().equals("flushVocabInMemory")){
			for(int i=0; i<13; i++)
				VaccibotClassify.vocab[i] = "";
			resp.sendRedirect("/admin?status=787");
		}
		
		else if(req.getParameter("action").trim().equals("checkForSync")){
			String Category[] = {"","","","","","","","","","","","",""};
			int DocCount[] = {0,0,0,0,0,0,0,0,0,0,0,0,0};
			int VocabCount[] = {0,0,0,0,0,0,0,0,0,0,0,0,0};
			double priorProbabilities[] = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
			

			int totalDocCount = 0;
			int totalVocabCount = 0;
			double totalpriorProbabilities = 0.0;
			for(int i=1; i<14; i++){
				KnowledgeRepository kr = OfyService.ofy().load().type(KnowledgeRepository.class).id(i).get();
				
				DocCount[i-1] =kr.docCount;
				totalDocCount = totalDocCount + kr.docCount;
				
				priorProbabilities[i-1] = kr.priorProbability;
				totalpriorProbabilities = totalpriorProbabilities + kr.priorProbability; 
				
				Category[i-1] = DropdownUtil.GetCategoryStringFromInt(i);
				
				VocabCount[i-1] = (OfyService.ofy().load().type(Vocabulary.class).filter("category", i)).count();
				totalVocabCount = totalVocabCount + VocabCount[i-1];
			}
				
			
			resp.getWriter().println("<table>"
					+ "						<tr>"
					+ "							<td><b>Category</b></td>"
					+ "							<td><b>DocCount</b></td>"
					+ "							<td><b>VocabCount</b></td>"
					+ "							<td><b>Prior Probabilities</b></td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td>"+Category[0]+"</td>"
					+ "							<td>"+DocCount[0]+"</td>"
					+ "							<td>"+VocabCount[0]+"</td>"
					+ "							<td>"+priorProbabilities[0]+"</td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td>"+Category[1]+"</td>"
					+ "							<td>"+DocCount[1]+"</td>"
					+ "							<td>"+VocabCount[1]+"</td>"
					+ "							<td>"+priorProbabilities[1]+"</td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td>"+Category[2]+"</td>"
					+ "							<td>"+DocCount[2]+"</td>"
					+ "							<td>"+VocabCount[2]+"</td>"
					+ "							<td>"+priorProbabilities[2]+"</td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td>"+Category[3]+"</td>"
					+ "							<td>"+DocCount[3]+"</td>"
					+ "							<td>"+VocabCount[3]+"</td>"
					+ "							<td>"+priorProbabilities[3]+"</td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td>"+Category[4]+"</td>"
					+ "							<td>"+DocCount[4]+"</td>"
					+ "							<td>"+VocabCount[4]+"</td>"
					+ "							<td>"+priorProbabilities[4]+"</td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td>"+Category[5]+"</td>"
					+ "							<td>"+DocCount[5]+"</td>"
					+ "							<td>"+VocabCount[6]+"</td>"
					+ "							<td>"+priorProbabilities[6]+"</td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td>"+Category[7]+"</td>"
					+ "							<td>"+DocCount[7]+"</td>"
					+ "							<td>"+VocabCount[7]+"</td>"
					+ "							<td>"+priorProbabilities[7]+"</td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td>"+Category[8]+"</td>"
					+ "							<td>"+DocCount[8]+"</td>"
					+ "							<td>"+VocabCount[8]+"</td>"
					+ "							<td>"+priorProbabilities[8]+"</td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td>"+Category[9]+"</td>"
					+ "							<td>"+DocCount[9]+"</td>"
					+ "							<td>"+VocabCount[9]+"</td>"
					+ "							<td>"+priorProbabilities[9]+"</td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td>"+Category[10]+"</td>"
					+ "							<td>"+DocCount[10]+"</td>"
					+ "							<td>"+VocabCount[10]+"</td>"
					+ "							<td>"+priorProbabilities[10]+"</td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td>"+Category[11]+"</td>"
					+ "							<td>"+DocCount[11]+"</td>"
					+ "							<td>"+VocabCount[11]+"</td>"
					+ "							<td>"+priorProbabilities[11]+"</td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td>"+Category[12]+"</td>"
					+ "							<td>"+DocCount[12]+"</td>"
					+ "							<td>"+VocabCount[12]+"</td>"
					+ "							<td>"+priorProbabilities[12]+"</td>"
					+ "						</tr>"
					+ "						<tr>"
					+ "							<td><b>Total</b></td>"
					+ "							<td>"+totalDocCount+"</td>"
					+ "							<td>"+totalVocabCount+"</td>"
					+ "							<td>"+totalpriorProbabilities+"</td>"
					+ "						</tr>"
					+ "			</table>");
		}
	}
}