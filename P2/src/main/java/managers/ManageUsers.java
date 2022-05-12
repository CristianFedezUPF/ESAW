package managers;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

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
			String degree, String country, LocalDate birthday, String position, String imagePath) {
		String query = "INSERT INTO user (name, username, email,"
				+ " password, gender, university, degree, country, birthday, position, image_path) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?)";
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
			statement.setObject(9, birthday, java.sql.Types.DATE);
			statement.setString(10,position);
			statement.setString(11,imagePath);
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	/*Check if all the fields are filled correctly */
	public boolean isComplete(User user) {
	    return(hasValue(user.getName()) &&
	    	   hasValue(user.getUsername()) &&
	    	   hasValue(user.getEmail()) &&
	           hasValue(user.getPassword()) &&
	           hasValue(user.getPasswordCheck()) &&
	           hasValue(user.getUniversity()));
	}
	
	private boolean hasValue(String val) {
		return((val != null) && (!val.equals("")));
	}
		
	
	// TODO: add other methods 

}
