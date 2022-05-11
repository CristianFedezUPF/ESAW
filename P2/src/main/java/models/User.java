package models;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.time.LocalDate;

public class User implements java.io.Serializable {
	
	/*
	 CREATE TABLE `users` (
  		`usr` varchar(255) NOT NULL,
  		`mail` varchar(255) NOT NULL,
  		`pwd` varchar(255) NOT NULL,
  		PRIMARY KEY (`usr`),
  		UNIQUE KEY `mail` (`mail`)
	 ); 
	 * 
	 */
	
	private static final long serialVersionUID = 1L;
	
	private String user = "";
	private String mail = "";
	private String pwd1 = "";
	private String pwd2 = "";
	
	private Long id;
	private String name;
	private String username;
	private String email;
	private String password;
	private String gender; 	// for now, change to ENUM later
	private String university;
	private String degree;
	private String country;
	private LocalDate birthday;
	private String type;	// student/teacher
	private String imagePath;
	
	
	private boolean[] error  = {false,false,false,false};
	
	public User() {
		
	}
	
	public String getUser() {
		return this.user;
	}
	
	public void setUser(String user) {
		/* We can simulate that a user with the same name exists in our DB and mark error[0] as true  */
		//error[0] = true;
		this.user = user;
		System.out.println(user);
	}
	
	public String getMail() {
		return this.mail;
	}
	
	public void setMail(String mail) {
		String regex = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(mail);
		if (matcher.matches()) {
			this.mail = mail;
			System.out.println(mail);
		} else {
			error[1]=true;
			System.out.println(mail);
		}
		
	}
	
	public String getPwd1() {
		return this.pwd1;
	}
	
	public void setPwd1(String pwd1) {
		/* TODO check restriction with pattern */
		this.pwd1 = pwd1;
		System.out.println(pwd1);
	}
	
	public String getPwd2() {
		return this.pwd2;
	}
	
	public void setPwd2(String pwd2) {
		/* TODO check restriction with pattern and check if pwd1=pwd2*/
		this.pwd2 = pwd2;
		System.out.println(pwd2);
	}
	
	public String getName() {
		return this.name;
	}
	
	public void setName(String name) {
		this.name = name;
		System.out.println(name);
	}
	
	public String getUsername() {
		return this.username;
	}
	
	public void setUsername(String username) {
		this.username = username;
		System.out.println(username);
	}
	
	public String getEmail() {
		return this.email;
	}
	
	public void setEmail(String email) {
		this.email = email;
		System.out.println(email);
	}
	
	public String getPassword() {
		return this.password;
	}
	
	public void setPassword(String password) {
		// hash
		this.password = password;
		System.out.println(password);
	}
	
	public String getGender() {
		return this.gender;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
		System.out.println(gender);
	}
	
	public String getUniversity() {
		return this.university;
	}
	
	public void setUniversity(String university) {
		this.university = university;
		System.out.println(university);
	}
	
	public String getDegree() {
		return this.degree;
	}
	
	public void setDegree(String degree) {
		this.degree = degree;
		System.out.println(degree);
	}

	public String getCountry() {
		return this.country;
	}
	
	public void setCountry(String country) {
		this.country = country;
		System.out.println(country);
	}
	
	public LocalDate getBirthday() {
		return this.birthday;
	}
	
	public void setBirthday(LocalDate birthday) {
		this.birthday = birthday;
		System.out.println(birthday);
	}
	
	public String getType() {
		return this.type;
	}
	
	public void setType(String type) {
		this.type = type;
		System.out.println(type);
	}
	
	public String getImagePath() {
		return this.imagePath;
	}
	
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
		System.out.println(imagePath);
	}
	
	public boolean[] getError() {
		return error;
	}
		
}
