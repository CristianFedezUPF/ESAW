package managers;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import models.User;
import utils.DB;

public class ManageUsers {
	
	private DB db = null ;
	
	public ManageUsers() {
		try {
			db = new DB();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void finalize() {
		try {
			db.disconnectBD();
		} catch (Throwable e) {
			e.printStackTrace();
		}
	}
		
	// Add new user
	public void addUser(String name, String username, String email, String password, String gender, String university,
			String degree, String country, Date birthday, String position, String imagePath, String salt) {
		String query = "INSERT INTO user (name, username, email,"
				+ " password, gender, university, degree, country, birthday, position, image_path, salt) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setString(1,name);
			statement.setString(2,username);
			statement.setString(3,email);
			statement.setString(4,password);
			statement.setString(5,gender);
			statement.setString(6,university);
			statement.setString(7,degree);
			statement.setString(8,country);
			statement.setDate(9, birthday);
			statement.setString(10,position);
			statement.setString(11,imagePath);
			statement.setString(12,salt);
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public boolean isUserRegistered(User user) throws SQLException {
		ResultSet rs;
		PreparedStatement statement;
		String query;
		
		// username
		String username = user.getUsername();
		query = "SELECT * FROM user WHERE username LIKE ?";
		statement = db.prepareStatement(query);
		statement.setString(1, username);
		rs = statement.executeQuery();
		if(rs.next()) {  // if there's some value in the result set, it's registered
			user.setError(4);
			return true;
		}
		
		// email
		String email = user.getEmail();
		query = "SELECT * FROM user WHERE email LIKE ?";
		statement =  db.prepareStatement(query);
		statement.setString(1, email);
		rs = statement.executeQuery();
		if(rs.next()) {
			user.setError(9);
			return true;
		}
		return false;
	}
	
	/*Check if the required fields are filled correctly */
	public boolean isComplete(User user) {
	    return(hasValue(user.getName()) &&
	    	   hasValue(user.getUsername()) &&
	    	   hasValue(user.getEmail()) &&
	           hasValue(user.getPassword()) &&
	           hasValue(user.getUniversity()));
	}
	
	private boolean hasValue(String val) {
		return((val != null) && (!val.equals("")));
	}
		
	
	// TODO: add other methods 

}
