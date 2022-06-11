package services;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.tuple.Pair;

import models.User;
import utils.DB;

public class UserService {
	
	private DB db = null ;
	
	public UserService() {
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
	
	/* Get a user given its PK*/
	public User getUser(Long long1) {
		String query = "SELECT id,name,mail FROM users WHERE id = ? ;";
		PreparedStatement statement = null;
		ResultSet rs = null;
		User user = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1,long1);
			rs = statement.executeQuery();
			if (rs.next()) {
				user = new User();
				user.setId(rs.getLong("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("mail"));
			}
			rs.close();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return user;
	}
	
	//public String getName(String )
		
	// Add new user
	public void addUser(User user) {
		String query = "INSERT INTO user (name, username, email,"
				+ " password, gender, university, degree, country, birthday, position, image_path, salt) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setString(1, user.getName());
			statement.setString(2, user.getUsername());
			statement.setString(3, user.getEmail());
			statement.setString(4, user.getPassword());
			statement.setString(5, user.getGender());
			statement.setString(6, user.getUniversity());
			statement.setString(7, user.getDegree());
			statement.setString(8, user.getCountry());
			statement.setDate(9, user.getBirthday());
			statement.setString(10, user.getPosition());
			statement.setString(11, user.getImagePath());
			statement.setString(12, user.getSalt());
			statement.executeUpdate();
			statement.close();
		} catch (SQLIntegrityConstraintViolationException e) {
			System.out.println(e.getMessage());
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
		user.setError(11);		
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
	
	public boolean isPasswordCorrect(User user) throws SQLException, NoSuchAlgorithmException, IOException {
		ResultSet rs;
		PreparedStatement statement;
		String query;
		
		String username = user.getUsername();
		String password = user.getLoginPassword();
		user.detroyLoginPassword();

		query = "SELECT * FROM user WHERE username LIKE ?";
		statement = db.prepareStatement(query);
		statement.setString(1, username);
		rs = statement.executeQuery();
		
		if(!rs.next()) return false;
		
		String dbPassword = rs.getString("password");		
		String dbSalt = rs.getString("salt");
				
		byte[] secret = "ESAW".getBytes();
		byte[] salt = dbSalt.getBytes(StandardCharsets.ISO_8859_1); 
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		outputStream.write(secret);
		outputStream.write(salt); 
		byte[] final_salt = outputStream.toByteArray();
		
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(final_salt);
		String hashedPassword = new String(md.digest(password.getBytes(StandardCharsets.ISO_8859_1)), StandardCharsets.ISO_8859_1);
				
		if(dbPassword.equals(hashedPassword)) {
			return true;
		}
		user.setError(10);
		return false;
	}
	
	// Follow a user
	public void followUser(Long long1, Long long2) {
		String query = "INSERT INTO follows (uid,fid) VALUES (?,?)";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1,long1);
			statement.setLong(2,long2);
			statement.executeUpdate();
			statement.close();
		} catch (SQLIntegrityConstraintViolationException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// Unfollow a user
	public void unfollowUser(Long long1, Long long2) {
		String query = "DELETE FROM follows WHERE uid = ? AND fid = ?";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1,long1);
			statement.setLong(2,long2);
			statement.executeUpdate();
			statement.close();
		} catch (SQLIntegrityConstraintViolationException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	// Get all the users
	public List<User> getUsers(Integer start, Integer end) {
		 // TODO UPDATE QUERY
		 String query = "SELECT id,name FROM users ORDER BY name ASC LIMIT ?,?;";
		 PreparedStatement statement = null;
		 List<User> l = new ArrayList<User>();
		 try {
			 statement = db.prepareStatement(query);
			 statement.setInt(1,start);
			 statement.setInt(2,end);
			 ResultSet rs = statement.executeQuery();
			 while (rs.next()) {
				 User user = new User();
				 user.setId(rs.getLong("id"));
				 user.setName(rs.getString("name"));
				 l.add(user);
			 }
			 rs.close();
			 statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return  l;
	}
	
	// TODO LO DE START Y END ES MEGA CUTRE
	public List<User> getNotFollowedUsers(Long long1, Integer start, Integer end) {
		 // TODO UPDATE QUERY 
		 String query = "SELECT id,name FROM users WHERE id NOT IN (SELECT id FROM users,follows WHERE id = fid AND uid = ?) AND id <> ? ORDER BY name LIMIT ?,?;";
		 PreparedStatement statement = null;
		 List<User> l = new ArrayList<User>();
		 try {
			 statement = db.prepareStatement(query);
			 statement.setLong(1,long1);
			 statement.setLong(2, long1);
			 statement.setInt(3,start);
			 statement.setInt(4,end);
			 ResultSet rs = statement.executeQuery();
			 while (rs.next()) {
				 User user = new User();
				 user.setId(rs.getLong("id"));
				 user.setName(rs.getString("name"));
				 l.add(user);
			 }
			 rs.close();
			 statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return  l;
	}
	// TODO LO DE START & END ES MEGA CUTRE
	public List<User> getFollowedUsers(Long long1, Integer start, Integer end) {
		 // TODO UPDATE QUERY
		 String query = "SELECT id,name FROM users,follows WHERE id = fid AND uid = ? ORDER BY name LIMIT ?,?;";
		 PreparedStatement statement = null;
		 List<User> l = new ArrayList<User>();
		 try {
			 statement = db.prepareStatement(query);
			 statement.setLong(1,long1);
			 statement.setInt(2,start);
			 statement.setInt(3,end);
			 ResultSet rs = statement.executeQuery();
			 while (rs.next()) {
				 User user = new User();
				 user.setId(rs.getLong("id"));
				 user.setName(rs.getString("name"));
				 l.add(user);
			 }
			 rs.close();
			 statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return  l;
	}
	
	public Pair<Boolean,User> getUserByUsername(User user) {
		// TODO update this
		String query = "SELECT id, email, name from user where username=? AND password=?";
		PreparedStatement statement = null;
		boolean output = false;
		try {
			statement = db.prepareStatement(query);
			statement.setString(1,user.getUsername());
			statement.setString(2,user.getLoginPassword());
			ResultSet rs = statement.executeQuery();
			if (rs.next()) {
				user.setId(rs.getLong("id"));
				user.setEmail(rs.getString("email"));
				user.setName(rs.getString("name"));;
				output = true;
			} 
			rs.close();
			statement.close();
		} catch (SQLIntegrityConstraintViolationException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return Pair.of(output,user);
		
	}
	
	public boolean checkUser(String user) {
		// TODO WHAT DOES THIS CHECK FOR? RENAME
		String query = "SELECT username from user where username=?";
		PreparedStatement statement = null;
		ResultSet rs = null;
		boolean output = false;
		try {
			
			statement = db.prepareStatement(query);
			statement.setString(1,user);
			rs = statement.executeQuery();
			if (rs.isBeforeFirst()) {
				output = true;
			}
			rs.close();
			statement.close();
			return output;
			
		} catch (SQLIntegrityConstraintViolationException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return output;
		
	}
	
	public boolean checkEmail(String email) {
		// TODO WHAT DOES THIS CHECK FOR? RENAME
		String query = "SELECT email from user where email=?";
		PreparedStatement statement = null;
		ResultSet rs = null;
		boolean output = false;
		try {
			
			statement = db.prepareStatement(query);
			statement.setString(1, email);
			rs = statement.executeQuery();
			if (rs.isBeforeFirst()) {
				output = true;
			}
			rs.close();
			statement.close();
			return output;
			
		} catch (SQLIntegrityConstraintViolationException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return output;
		
	}
	
	//TODO change this
	/*Check if all the fields are filled correctly */
	public boolean isComplete(User user) {
	    return(hasValue(user.getName()) &&
	    	   hasValue(user.getEmail()) &&
	    	   hasValue(user.getPassword()) );
	}
	
	public boolean isLoginComplete(User user) {
	    return(hasValue(user.getUsername()) &&
	    	   hasValue(user.getPassword()) );
	}
	
	private boolean hasValue(String val) {
		return((val != null) && (!val.equals("")));
	}
		
	
	// TODO: add other methods 

}