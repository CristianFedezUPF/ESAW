package models;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class User implements java.io.Serializable {

private static final long serialVersionUID = 1L;
	
	private String name;
	private String username;
	private String email;
	private String password;
	private String passwordCheck;
	private String gender;
	private String university;
	private String degree;
	private String country;
	private Date birthday;
	private String position;	// student/teacher
	private String imagePath;
	
	private String salt;
	
	//to store the unhashed password so we can verify it matches when login
	private String loginPassword;
	// TODO change errors to integer codes.
	
	//[0] = Name missing [1] = Username missing [2] = Username length invalid [3] = Username not valid
	//[4] = Username in use. [5] = Email not valid. [6] = Password too short. [7] = Password must be alphanumeric.
	//[8] = Degree must contain only text characters. [9] = Email in use.
	
	private boolean[] error  = {false,false,false,false,false,false,false,false,false,false};
	
	public User() {
		
	}
	
	public String getName() {
		return this.name;
	}
	
	public void setName(String name) {
		name = name.trim();
		if(name.length() < 1) {
			error[0] = true;
		}
		else {
			this.name = name;
			System.out.println(name);
		}
	}
	
	public String getUsername() {
		return this.username;
	}
	
	public void setUsername(String username) {
		username = username.trim();
		int length = username.length();
		if(length < 1) {
			error[1] = true;
		}
		else if(length < 4 || length > 15) {
			error[2] = true;
		}
		String regex = "^[a-zA-Z0-9]+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(username);
		if(matcher.matches()) {
			this.username = username;
			System.out.println(username);
		}
		else {
			error[3] = true;
		}
	}
	
	public String getEmail() {
		return this.email;
	}
	
	public void setEmail(String email) {
		email = email.trim();
		String regex = "[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(email);
		if (matcher.matches()) {
			this.email = email;
			System.out.println(email);
		} else {
			error[5] = true;
			System.out.println(email);
		}
	}
	
	public String getPassword() {
		return this.password;
	}
	
	public void setPassword(String password) throws NoSuchAlgorithmException, IOException {
		password = password.trim();
		if(password.length() < 6) {
			error[6] = true;
		}
		String regex = "^[a-zA-Z0-9]+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(password);
		if (!matcher.matches()) {
			error[7] = true;
			System.out.println(password);
			return;
		}
		
		loginPassword = password;
		
		SecureRandom random = new SecureRandom();
		byte[] salt = new byte[16]; 
		random.nextBytes(salt); // create random 16-byte salt
		byte[] secret = "ESAW".getBytes();
		
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		outputStream.write(secret);
		outputStream.write(salt); 
		byte[] final_salt = outputStream.toByteArray(); // final salt is secret + salt
		
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(final_salt);
		
		this.salt = new String(salt, StandardCharsets.ISO_8859_1); // store salt as String
		String hashedPassword = new String(md.digest(password.getBytes(StandardCharsets.ISO_8859_1)), StandardCharsets.ISO_8859_1); //hash and store as String
		
		this.password = hashedPassword;
		System.out.println(hashedPassword);
	}
	
	public String getPasswordCheck() {
		return this.passwordCheck;
	}
	
	public void setPasswordCheck(String password) {
		password = password.trim();
		this.passwordCheck = password;
		System.out.println(password);
	}
	
	public String getGender() {
		return this.gender;
	}
	
	public void setGender(String gender) {
		gender = gender.trim();
		this.gender = gender;
		System.out.println(gender);
	}
	
	public String getUniversity() {
		return this.university;
	}
	
	public void setUniversity(String university) {
		university = university.trim();
		this.university = university;
		System.out.println(university);
	}
	
	public String getDegree() {
		return this.degree;
	}
	
	public void setDegree(String degree) {
		degree = degree.trim();
		if(degree.length() == 0) {
			return;
		}
		String regex = "^[a-zA-Z ]+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(degree);
		if (matcher.matches()) {
			this.degree = degree;
			System.out.println(degree);
		} else {
			error[8] = true;
			System.out.println(degree);
		}
	}

	public String getCountry() {
		return this.country;
	}
	
	public void setCountry(String country) {
		country = country.trim();
		this.country = country;
		System.out.println(country);
	}
	
	public Date getBirthday() {
		return this.birthday;
	}
	
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
			      
		System.out.println(birthday);
	}
	
	public String getPosition() {
		return this.position;
	}
	
	public void setPosition(String position) {
		position = position.trim();
		this.position = position;
		System.out.println(position);
	}
	
	public String getImagePath() {
		return this.imagePath;
	}
	
	public void setImagePath(String imagePath) {
		imagePath = imagePath.trim();
		this.imagePath = imagePath;
		System.out.println(imagePath);
	}
	
	public boolean[] getError() {
		return error;
	}
	
	public void setError(int index) {
		this.error[index] = true;
	}
	
	public String getSalt() {
		return this.salt;
	}
	
	public String getLoginPassword() {
		return this.loginPassword;
	}
	
	public void detroyLoginPassword() {
		this.loginPassword = "";
	}
	
	public boolean isComplete() {
	    return(hasValue(this.getName()) &&
	    	   hasValue(this.getUsername()) &&
	    	   hasValue(this.getEmail()) &&
	           hasValue(this.getPassword()) &&
	           hasValue(this.getUniversity()));
	}
	
	public boolean isLoginComplete() {
	    return(hasValue(this.getUsername()) &&
	           hasValue(this.getPassword()));
	}
	
	private boolean hasValue(String val) {
		return((val != null) && (!val.equals("")));
	}
	
}
