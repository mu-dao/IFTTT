package com.entity;

public class User implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	private String name;
	private String password;
	private String sex;
	private String year;
	private String month;
	private String day;
	private String email;
	private String phone;
	private String money;
	private String level;
	private String point;

	public User(){}
	
	public String getName(){
		return this.name;
	}
	
	public void setName(String name){
		this.name = name;
	}
	
	public String getPassword(){
		return this.password;
	}
	
	public void setPassword(String password){
		this.password = password;
	}
	
	public String getSex(){
		return this.sex;
	}
	
	public void setSex(String sex){
		this.sex = sex;
	}
	
	public String getYear(){
		return this.year;
	}
	
	public void setYear(String year){
		this.year = year;
	}
	
	public String getMonth(){
		return this.month;
	}
	
	public void setMonth(String month){
		this.month = month;
	}
	
	public String getDay(){
		return this.day;
	}
	
	public void setDay(String day){
		this.day = day;
	}
	
	public String getEmail(){
		return this.email;
	}
	
	public void setEmail(String email){
		this.email = email;
	}
	
	public String getPhone(){
		return this.phone;
	}
	
	public void setPhone(String phone){
		this.phone = phone;
	}

	public void setMoney(String money) {
		this.money = money;
	}
	
	public String getMoney(){
		return this.money;
	}
	
	public void setLevel(String level){
		this.level = level;
	}
	
	public String getLevel(){
		return this.level;
	}
	
	public void setPoint(String point){
		this.point = point;
	}
	
	public String getPoint(){
		return this.point;
	}
}
