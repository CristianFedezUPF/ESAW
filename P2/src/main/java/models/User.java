package models;

import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.time.LocalDate;
import java.time.ZoneId;

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
	
	private String name;
	private String username;
	private String email;
	private String password;
	private String passwordCheck;
	private String gender; 	// for now, change to ENUM later
	private String university;
	private String degree;
	private String country;
	private LocalDate birthday;
	private String position;	// student/teacher
	private String imagePath;
	
	
	private boolean[] error  = {false,false,false,false};
	
	public User() {
		
	}
	
	
	//public void setUser(String user) {
		/* We can simulate that a user with the same name exists in our DB and mark error[0] as true  *//*
		//error[0] = true;
		this.user = user;
		System.out.println(user);
	}*/
	
	
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
		String regex = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(email);
		if (matcher.matches()) {
			this.email = email;
			System.out.println(email);
		} else {
			error[1] = true;
			System.out.println(email);
		}
	}
	
	public String getPassword() {
		return this.password;
	}
	
	public String getPasswordCheck() {
		return this.passwordCheck;
	}
	
	public void setPassword(String password) {
		// hash
		this.password = password;
		System.out.println(password);
	}
	
	public void setPasswordCheck(String password) {
		// hash
		this.passwordCheck = password;
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
	
	public void setBirthday(Date birthday) {
		this.birthday = birthday.toInstant()
			      .atZone(ZoneId.systemDefault())
			      .toLocalDate();;
			      
		System.out.println(birthday);
	}
	
	public String getPosition() {
		return this.position;
	}
	
	public void setPosition(String position) {
		this.position = position;
		System.out.println(position);
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
