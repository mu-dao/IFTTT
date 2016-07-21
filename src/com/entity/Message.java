package com.entity;

public class Message implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String isall;
	private String toMember;
	private String fromMember;
	private String title;
	private String content;
	private String time;

	public Message(){}
	
	public String getId(){
		return this.id;
	}
	
	public void setId(String id){
		this.id = id;
	}
	
	public String getIsAll(){
		return this.isall;
	}
	
	public void setIsAll(String isall){
		this.isall = isall;
	}
	
	public String getToMember(){
		return this.toMember;
	}
	
	public void setToMember(String toMember){
		this.toMember = toMember;
	}
	
	public String getFromMember(){
		return this.fromMember;
	}
	
	public void setFromMember(String fromMember){
		this.fromMember = fromMember;
	}
	
	public String getTitle(){
		return this.title;
	}
	
	public void setTitle(String title){
		this.title = title;
	}
	
	public String getContent(){
		return this.content;
	}
	
	public void setContent(String content){
		this.content = content;
	}
	
	public String getTime(){
		return this.time;
	}
	
	public void setTime(String time){
		this.time = time;
	}
}
