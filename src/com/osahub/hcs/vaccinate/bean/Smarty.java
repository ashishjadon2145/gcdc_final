package com.osahub.hcs.vaccinate.bean;

import static com.osahub.hcs.vaccinate.services.dataaccess.OfyService.ofy;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import com.google.appengine.api.datastore.QueryResultIterator;
import com.osahub.hcs.vaccinate.services.dataaccess.OfyService;
import com.osahub.hcs.vaccinate.controller.vaccinate.VaccibotClassify;
import com.osahub.hcs.vaccinate.dao.user.YoutubeBroadcast;
import com.osahub.hcs.vaccinate.dao.vaccibot.AnswersRepository;
import com.osahub.hcs.vaccinate.dao.vaccibot.KnowledgeRepository;
import com.osahub.hcs.vaccinate.dao.vaccibot.Vocabulary;
import com.osahub.hcs.vaccinate.util.DropdownUtil;

public class Smarty {
	//declaring and initialize with blank string
	//public static String[] vocab = {"","","","","","","","","","","","",""}; 
	public ArrayList<Double> priorProbability;
	public String fillers = "each every its this that , . / ; ' [ ] \\ < > ? : \" { } | ! @ # $ % ^ & * ( ) _ + = -  is am are he she it they my your you using use used on at to for will shall have go gone went be in of do does yourself the a an no another some any our their her his 1 2 3 4 5 6 7 8 9 0 etc. etc";

	
	public String getAnswer(String question)
	{
		//classifying input question into a particular category 
		String category = findCategory(question, "categoryAsNumber");
		
		//giving back an appropriate answer		
		return getRandomAnswer(Integer.parseInt(category)); 
		
	}
	
	private String getRandomAnswer(int category){
		String response ="";
		boolean flagToCheckIfAllAnswersAreUsed = true;
		QueryResultIterator<AnswersRepository> answerIterator = OfyService.ofy().load().type(AnswersRepository.class).filter("category",category).filter("used",false).iterator();
		if( answerIterator != null){
			while(answerIterator.hasNext()){
				flagToCheckIfAllAnswersAreUsed = false;
				AnswersRepository answer = answerIterator.next();
				response = answer.answer;
				answer.used = true;
				ofy().save().entities(answer);
				ofy().clear();
				break;
			}
		}
		
		if(flagToCheckIfAllAnswersAreUsed) {
			answerIterator = OfyService.ofy().load().type(AnswersRepository.class).filter("category",category).iterator();
			while(answerIterator.hasNext()){
				AnswersRepository answer = answerIterator.next();
				response = answer.answer;
				answer.used = false;
				ofy().save().entities(answer);
				ofy().clear();
			}
		}
		return response;
	}
	
	public String findCategory(String source, String mode)
	{
		//extracting words from sentence
		List<String> inputWords = extractWords(source);
		
		//removing fillers for 'bag of words' implementation
		List<String> processedWords = removeFillers(inputWords);
		if(mode.equalsIgnoreCase("categoryAsNumber"))
			return  String.valueOf(getLikelyhood(processedWords) );
		else
			return  DropdownUtil.GetCategoryStringFromInt(getLikelyhood(processedWords)) ;
	}
	

    //method to split the Input String and Implement Bag of Words
	private ArrayList<String> extractWords(String source)
	{
		ArrayList<String> chunks = new ArrayList<String>();
		StringTokenizer st = new StringTokenizer(source);
		System.out.println("tockenizing String : "+source);
		String currentWord = "";
		while (st.hasMoreElements()) {
			currentWord = st.nextElement().toString(); 
			if( countOccurance(fillers, currentWord) == 0){
			//if(!fillers.contains(currentWord.toLowerCase())){
				chunks.add(currentWord);
			System.out.println("filtered word = "+currentWord);}
		}
		
		return chunks;
	}

	private int getLikelyhood(List<String> words)
	{
		//length is 7 representing each class and initialize each element to 1 (if smooting) else to 0
		double likelyhood[] ={0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0} ;      
		double pWords[] = new double[words.size()];
		int occuranceWords[] = new int[words.size()]  ;
		int classWithMaxLikelyhood = 8;
		double temp = 0.0;
		//will iterate 7 times for each probability
        	for (int i=1; i < 8; i++){
    			//occuranceWords = null; //or intialize here to zero
    			int totalOccurance=0;
                	System.out.println("iteration/class = "+i+"/"+DropdownUtil.GetCategoryStringFromInt(i));
    			int j=0;
    			String tempString = "";
    			for (String it : words)
    			{
    				//adding 1 for smoothing
    				//int count = countOccurance( VaccibotClassify.vocab[i-1], it)+1;
    				int count = countOccurance( VaccibotClassify.vocab[i-1], it);
    				//since we have added unique keywords in the vocab (not sentences) , so here we will get count either 1 or 2
    				occuranceWords[j] = count;
                	
                	System.out.println("\toccurance of word "+(j+1)+"  : "+count);		
    				
    				//to neutralize impact of duplicate words on total word count
    				
    				if( countOccurance(tempString, it) == 0)
      				{
    					totalOccurance = totalOccurance + count;
    					tempString = tempString+" "+it;
      				}

    				j++;
    			}
    				System.out.println("\t total occurance="+totalOccurance);
    				System.out.println("\t probability of each word is as follows");
    			for(int k=0; k<words.size(); k++)
    			{
    				if (occuranceWords[k] == 0)
    					pWords[k] = 0.0;
    				else
    					pWords[k] = (double)occuranceWords[k]/totalOccurance;
    				System.out.println("\t\tfor word "+(k+1)+" : "+pWords[k]);
    				
    				if(pWords[k] > 0.0)
    				{
    					if(likelyhood[i-1] == 0.0)
    						likelyhood[i-1] = 1.0;
    					likelyhood[i-1] = likelyhood[i-1] * pWords[k];
    				}
    			}

    			likelyhood[i-1] = likelyhood[i-1] * VaccibotClassify.priorProbability[i-1];
                
    				System.out.println("\tPosterior Probability : "+likelyhood[i-1]);

    			if(temp < likelyhood[i-1])
    			{
    				classWithMaxLikelyhood = i;
    				temp = likelyhood[i-1];
    			}
    		}
		return classWithMaxLikelyhood;
	}
	

	private List<String> removeFillers(List<String> words){
		return words;
	}
	
	//count exact words when the string is separated by space
	public int countOccurance(String knowledgeRepository, String word) {
		int count  = 0;
        StringTokenizer st = new StringTokenizer(knowledgeRepository);
        
        while(st.hasMoreElements()){
            if(st.nextElement().toString().equalsIgnoreCase(word))
                count++;
        }
        
        return count;
	}
}
