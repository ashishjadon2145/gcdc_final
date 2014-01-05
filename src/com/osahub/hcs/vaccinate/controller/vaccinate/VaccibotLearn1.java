package com.osahub.hcs.vaccinate.controller.vaccinate;

import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;
import com.osahub.hcs.vaccinate.dao.vaccibot.AnswersRepository;
import com.osahub.hcs.vaccinate.dao.vaccibot.KnowledgeRepository;
import com.osahub.hcs.vaccinate.dao.vaccibot.Vocabulary;
import com.osahub.hcs.vaccinate.util.DropdownUtil;

public class VaccibotLearn1 extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		if(req.getParameter("action").trim().equalsIgnoreCase("addVocab")){
			String category = req.getParameter("category1").trim();
			int catg = Integer.parseInt(category);
			String content = req.getParameter("content").trim().toUpperCase();

			if (OfyService.ofy().load().type(Vocabulary.class).id(content).get() == null) {
				try{
			// 	creating repository
					creatingRepository(catg);
					
			// 	creating vocabulary
					creatingVocabulary(catg, content);
					
			// 	updating vocabulary for classifier
					loadVocabForClassifier( catg,  content);
					
			// 	calculate and updating prior probabilities for classifier
					//updatePriorProbabilities();
					
					resp.getWriter().println("everything completed successfully");
					
				}catch(Exception d){
					resp.getWriter().println("error creating repository/vocabulary or updating prior probability");	
					resp.getWriter().println("\nMessage  : "+d.toString());
				}
				
			} else
				resp.getWriter().println("duplicate entry");
		} else if(req.getParameter("action").trim().equalsIgnoreCase("addAnswer")){
			try{
				String category = req.getParameter("category2").trim();
				int catg = Integer.parseInt(category);
				String inputAnswer = req.getParameter("inputAnswer").trim().toUpperCase();

				AnswersRepository answer  = new AnswersRepository(inputAnswer, catg);
				ofy().save().entities(answer);
				ofy().clear();
				resp.getWriter().println("everything completed successfully");
			} catch(Exception d){
				resp.getWriter().println("error creating repository/vocabulary or updating prior probability");	
				resp.getWriter().println("\nMessage  : "+d.toString());
			}
		}
	}

	public void creatingRepository(int catg) {
		KnowledgeRepository knowledge = null;
			knowledge = OfyService.ofy().load().type(KnowledgeRepository.class).id(catg).get();

			if (knowledge == null)
				knowledge = new KnowledgeRepository(catg, DropdownUtil.GetCategoryStringFromInt(catg));

			//knowledge.docCount = knowledge.docCount + 1;// this means we need not to verify the vocab input its going into DB with verified='true'
			// Now save the object
			ofy().save().entities(knowledge);
			ofy().clear();
	}
	

	public void creatingVocabulary(int catg, String content) {
		Vocabulary vocab = null;
		vocab = new Vocabulary(catg, content, "admin@osahub.com", new Date(), "admin@osahub.com", new Date());
		ofy().save().entities(vocab);
		ofy().clear();
	}
	

	public void loadVocabForClassifier(int catg, String content) {
		/*if(VaccibotClassify.vocab[catg-1] == null || VaccibotClassify.vocab[catg-1].length()==0 ){
			//first try to fetch and set all existing records from database
			QueryResultIterator<Vocabulary> vocabIterator = OfyService.ofy().load().type(Vocabulary.class).filter("category",catg).iterator();
			if( vocabIterator != null){
				while(vocabIterator.hasNext()){
					Vocabulary vocab = vocabIterator.next();
					VaccibotClassify.vocab[catg-1] = VaccibotClassify.vocab[catg-1]+vocab.content;
				}
			}
		}*/
		VaccibotClassify.vocab[catg-1] = VaccibotClassify.vocab[catg-1]+" "+content;
	}
	

	public static void updatePriorProbabilities() {
		// getting totalDocCount
		int totalDocCount = 0;
		totalDocCount = (OfyService.ofy().load().type(Vocabulary.class)).count()+1;
		// int totalDocCount = (OfyService.ofy().load().type(Vocabulary.class).filter("verified", true)).count(); right now by default all vocab are verified
		//System.out.println("totalDocCount = " + totalDocCount);

		// getting docCount and updating priorProbability for each category
		KnowledgeRepository knowledge1 = null;

		for (int i = 1; i < 8; i++) {
				knowledge1 = OfyService.ofy().load().type(KnowledgeRepository.class).id(i).get();

				if (knowledge1 == null) {
					knowledge1 = new KnowledgeRepository(i, DropdownUtil.GetCategoryStringFromInt(i));
					//System.out.println("created knowledge repo = "+ knowledge1.description);
				}

				if (knowledge1.docCount != 0) {
					//System.out.println("For " + knowledge1.description+ "\n\told PP = " + knowledge1.priorProbability + "\n\t doc count = " + knowledge1.docCount);
					knowledge1.priorProbability = (double) knowledge1.docCount / totalDocCount;
					//System.out.println("\t new PP = " + knowledge1.priorProbability);
				} else {
					//System.out.println("For " + knowledge1.description + "\n\told PP = " + knowledge1.priorProbability + "\n\t doc count = " + knowledge1.docCount + "\n\t so, new PP not calculated");
				}

				// Now save the object
				ofy().save().entities(knowledge1);
				ofy().clear();
		}
	}
}