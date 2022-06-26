package models;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class User implements java.io.Serializable {

private static final long serialVersionUID = 1L;

	private Long id;
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
	private Integer postCount;
	private Integer followingCount;
	private Integer followerCount;
	private String position;	// student/teacher
	private boolean isAdmin;
	private String imagePath;
	
	private String salt;
	
	//to store the unhashed password so we can verify it matches when login
	private String loginPassword;
	
	//[0] = Name missing [1] = Username missing [2] = Username length invalid [3] = Username not valid
	//[4] = Username in use. [5] = Email not valid. [6] = Password too short. [7] = Password must be alphanumeric.
	//[8] = Degree must contain only text characters. [9] = Email in use. [10] = Passwords do not match (login)
	//[11] = User does not exist (login). [12] = DB error/internal server error
	//[13] = Other, unexpected errors
	
	private HashMap<String,Boolean> error = null;
	
	public User() {
		error = new HashMap<String, Boolean>();
	}
	
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		if(id <= 0) {
			error.put("13", true);
			return;
		}
		this.id = id;
	}
	
	public String getName() {
		return this.name;
	}
	
	public void setName(String name) {
		name = name.trim();
		if(name.length() < 1) {
			error.put("0", true);
			return;
		}
		this.name = name;
	}
	
	public String getUsername() {
		return this.username;
	}
	
	public void setUsername(String username) {
		username = username.trim();
		int length = username.length();
		if(length < 1) {
			error.put("1", true);
			return;
		}
		else if(length < 4 || length > 15) {
			error.put("2", true);
			return;
		}
		String regex = "^[a-zA-Z0-9]+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(username);
		if(matcher.matches()) {
			this.username = username;
		}
		else {
			error.put("3", true);
			return;
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
		} else {
			error.put("5", true);
		}
	}
	
	public String getPassword() {
		return this.password;
	}
	
	public void setPassword(String password) throws NoSuchAlgorithmException, IOException {
		password = password.trim();
		if(password.length() < 6) {
			error.put("6", true);
		}
		String regex = "^[a-zA-Z0-9]+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(password);
		if (!matcher.matches()) {
			error.put("7", true);
			return;
		}
		
		loginPassword = password;
		
		SecureRandom random = new SecureRandom();
		byte[] salt = new byte[16]; 
		random.nextBytes(salt); // create random 16-byte salt
		
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(salt);
		
		this.salt = new String(salt, StandardCharsets.ISO_8859_1); // store salt as String
		String hashedPassword = new String(md.digest(password.getBytes(StandardCharsets.ISO_8859_1)), StandardCharsets.ISO_8859_1); //hash and store as String
		
		this.password = hashedPassword;
	}
	
	public String getPasswordCheck() {
		return this.passwordCheck;
	}
	
	public void setPasswordCheck(String password) {
		password = password.trim();
		if(password.length() < 6) {
			error.put("6", true);
		}
		String regex = "^[a-zA-Z0-9]+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(password);
		if (!matcher.matches()) {
			error.put("7", true);
			return;
		}
		this.passwordCheck = password;
	}
	
	public String getGender() {
		return this.gender;
	}
	
	public void setGender(String gender) {
		gender = gender.trim();
		if (!gender.matches("M|F|NB|NS") && gender != null) {
			error.put("13", true);
			return;
		}
		this.gender = gender;
	}
	
	public String getUniversity() {
		return this.university;
	}
	
	public void setUniversity(String university) {
		university = university.trim();
		if(university.length() > 255) {
			error.put("13", true);
			return;
		}
		this.university = university;
	}
	
	public String getDegree() {
		return this.degree;
	}
	
	public void setDegree(String degree) {
		if (degree == null) return;
		degree = degree.trim();
		if(degree.length() == 0) {
			return;
		}
		String regex = "^[a-zA-Z ]+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(degree);
		if (matcher.matches()) {
			this.degree = degree;
		} else {
			error.put("8", true);
		}
	}

	public String getCountry() {
		return this.country;
	}
	
	public void setCountry(String country) {
		if(country != null && country.equals("0")){
			this.country = null;
		}
		else if(country == null) {
			this.country = country;
		}
		else {
			country = country.trim();
			if(country.length() > 64) {
				error.put("13", true);
				return;
			}
			this.country = country;
		}
	}
	
	public Date getBirthday() {
		return this.birthday;
	}
	
	public void setBirthday(Date birthday) {
		if (birthday != null && !isDateValid(birthday.toString())) {
			error.put("13", true);
			return;
		}
		this.birthday = birthday;
	}
	
	public Integer getPostCount() {
		return this.postCount;
	}
	
	public void setPostCount(Integer count) {
		if(count < 0) {
			error.put("13", true);
			return;
		}
		this.postCount = count;
	}
	
	public Integer getFollowingCount() {
		return this.followingCount;
	}
	
	public void setFollowingCount(Integer count) {
		if(count < 0) {
			error.put("13", true);
			return;
		}
		this.followingCount = count;
	}
	
	public Integer getFollowerCount() {
		return this.followerCount;
		
	}
	
	public void setFollowerCount(Integer count) {
		if(count < 0) {
			error.put("13", true);
			return;
		}
		this.followerCount = count;
	}
	
	public String getPosition() {
		return this.position;
	}
	
	public void setPosition(String position) {
		position = position.trim();
		if (!position.matches("S|T") && position != null) {
			error.put("13", true);
			return;
		}
		this.position = position;
	}
	
	public boolean getIsAdmin() {
		return this.isAdmin;
		
	}
	
	public void setIsAdmin(boolean val) {
		this.isAdmin = val;
	}
	
	public String getImagePath() {
		return this.imagePath;
	}
	
	public void setImagePath(String imagePath) {
		if (imagePath == null) return;
		imagePath = imagePath.trim();
		this.imagePath = imagePath;
	}
	
	public HashMap<String,Boolean> getError() {
		return this.error;
	}
	
	public void setError(String name, boolean error) {
		this.error.put(name, error);
	}
	
	public void resetError() {
		this.error.clear();
	}
	
	public String getSalt() {
		return this.salt;
	}
	
	public String getLoginPassword() {
		return this.loginPassword;
	}
	
	public void destroyLoginPassword() {
		this.loginPassword = "";
	}
	
	public boolean isComplete() {
	    return(hasValue(this.getName()) &&
	    	   hasValue(this.getUsername()) &&
	    	   hasValue(this.getEmail()) &&
	           hasValue(this.getPassword()) &&
	           hasValue(this.getUniversity()) &&
	           this.loginPassword.equals(passwordCheck));
	}
	
	public boolean isLoginComplete() {
	    return(hasValue(this.getUsername()) &&
	           hasValue(this.getPassword()));
	}
	
	public boolean isEditComplete() {
		return(hasValue(this.getUsername()) &&
				hasValue(this.getName()) && 
				hasValue(this.getUniversity()));
	}
	
	private boolean hasValue(String val) {
		return((val != null) && (!val.equals("")));
	}

	private boolean isDateValid(String date) 
	{
	        try {
	            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	            df.setLenient(false);
	            df.parse(date);
	            return true;
	        } catch (ParseException e) {
	            return false;
	        }
	}
	
}
