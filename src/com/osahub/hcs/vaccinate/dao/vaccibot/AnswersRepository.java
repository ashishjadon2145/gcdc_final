package com.osahub.hcs.vaccinate.dao.vaccibot;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;



@Entity
public class AnswersRepository{
	@Id public String answer ;
	@Index public int category;
	@Index public boolean used;
	
		
	//default constructor for objectify
	public AnswersRepository(){
		
	}
	
	//constructor
	public AnswersRepository(String answer, int category) {
		super();
		this.answer = answer;
		this.category = category;
		this.used = false;
	}
}