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

	public User getUser(Long userId) {
		String query = "SELECT user.id, user.username, user.name, user.university,\r\n"
				+ "user.degree, user.country, user.position, \r\n"
				+ "user.post_count, user.follower_count, user.following_count,\r\n"
				+ "user.birthday\r\n"
				+ "FROM user WHERE user.id = ?;";
		PreparedStatement statement = null;
		ResultSet rs = null;
		User user = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1, userId);
			rs = statement.executeQuery();
			if (rs.next()) {
				user = new User();
				user.setId(rs.getLong("id"));
				user.setUsername(rs.getString("username"));
				user.setName(rs.getString("name"));
				user.setUniversity(rs.getString("university"));
				user.setDegree(rs.getString("degree"));
				user.setCountry(rs.getString("country"));
				user.setPosition(rs.getString("position"));
				user.setPostCount(rs.getInt("post_count"));
				user.setFollowingCount(rs.getInt("following_count"));
				user.setFollowerCount(rs.getInt("follower_count"));
				user.setBirthday(rs.getDate("birthday"));
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
	
	// Add new user
	public void editUser(User user) {
		String query = "UPDATE user\r\n"
				+ "SET\r\n"
				+ "name = ?,\r\n"
				+ "username = ?,\r\n"
				+ "country = ?,\r\n"
				+ "university = ?,\r\n"
				+ "position = ?,\r\n"
				+ "degree = ?\r\n"
				+ "WHERE id = ?;";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setString(1, user.getName());
			statement.setString(2, user.getUsername());
			statement.setString(3, user.getCountry());
			statement.setString(4, user.getUniversity());
			statement.setString(5, user.getPosition());
			statement.setString(6, user.getDegree());
			statement.setLong(7, user.getId());
			statement.executeUpdate();
			statement.close();
		} catch (SQLIntegrityConstraintViolationException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void deleteUser(Long userId) {
		String query = "DELETE FROM user WHERE id = ?";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1, userId);
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
		try {
			statement = db.prepareStatement(query);
		} catch(NullPointerException e) {
			user.setError("12", true);
			return true;
		}
		statement.setString(1, username);
		rs = statement.executeQuery();
		if(rs.next()) {  // if there's some value in the result set, it's registered
			user.setError("4", true);
			return true;
		}
		user.setError("11", true);		
		// email
		String email = user.getEmail();
		query = "SELECT * FROM user WHERE email LIKE ?";
		statement =  db.prepareStatement(query);
		statement.setString(1, email);
		rs = statement.executeQuery();
		if(rs.next()) {
			user.setError("9", true);
			return true;
		}
		return false;
	}
	
	public boolean isNewUsernameUsed(User user, String username) throws SQLException {
		ResultSet rs;
		PreparedStatement statement;
		String query;
		try {
			// username
			query = "SELECT * FROM user WHERE username LIKE ?";
			statement = db.prepareStatement(query);
			statement.setString(1, username);
			rs = statement.executeQuery();
			if(rs.next()) {  // if there's some value in the result set, it's registered
				if (user.getId().equals(rs.getLong("id"))) {
					return false;
				}
				user.setError("4", true);
				return true;
			}
			return false;
		}
		catch(SQLException e) {
			e.printStackTrace();
			return true;
		}
	
	}
	
	public boolean isPasswordCorrect(User user) throws SQLException, NoSuchAlgorithmException, IOException {
		ResultSet rs;
		PreparedStatement statement;
		String query;
		
		String username = user.getUsername();
		String password = user.getLoginPassword();
		user.destroyLoginPassword();

		query = "SELECT * FROM user WHERE username LIKE ?";
		try {
			statement = db.prepareStatement(query);
		} catch (NullPointerException e){
			user.setError("12", true);
			return false;
		}
		statement.setString(1, username);
		rs = statement.executeQuery();
		
		if(!rs.next()) return false;
		
		String dbPassword = rs.getString("password");		
		String dbSalt = rs.getString("salt");
				
		byte[] salt = dbSalt.getBytes(StandardCharsets.ISO_8859_1); 
		
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(salt);
		String hashedPassword = new String(md.digest(password.getBytes(StandardCharsets.ISO_8859_1)), StandardCharsets.ISO_8859_1);
				
		if(dbPassword.equals(hashedPassword)) {
			return true;
		}
		user.setError("10", true);
		return false;
	}
	
	// Follow a user
	public void followUser(Long followerId, Long followedId) {
		String query = "INSERT INTO follows (follower_id, followed_id) VALUES (?,?)";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1, followerId);
			statement.setLong(2, followedId);
			statement.executeUpdate();
			statement.close();
		} catch (SQLIntegrityConstraintViolationException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// Unfollow a user
	public void unfollowUser(Long followerId, Long followedId) {
		String query = "DELETE FROM follows WHERE follower_id = ? AND followed_id = ?";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1, followerId);
			statement.setLong(2, followedId);
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
	
	public List<User> getWhoToFollow(Long userId, Integer amount){
		 String query = "SELECT user.id, user.username, user.name, user.university, user.degree\r\n"
		 		+ "FROM user\r\n"
		 		+ "WHERE user.id NOT IN\r\n"
		 		+ "(SELECT user.id \r\n"
		 		+ "FROM user JOIN follows ON user.id = follows.followed_id\r\n"
		 		+ "WHERE follows.follower_id = ?)\r\n"
		 		+ "AND user.id != ?\r\n"
		 		+ "ORDER BY rand()\r\n"
		 		+ "LIMIT ?";
		 PreparedStatement statement = null;
		 List<User> users = new ArrayList<User>();
		 try {
			 statement = db.prepareStatement(query);
			 statement.setLong(1, userId);
			 statement.setLong(2, userId);
			 statement.setInt(3, amount);
			 ResultSet rs = statement.executeQuery();
			 while (rs.next()) {
				 User user = new User();
				 user.setId(rs.getLong("id"));
				 user.setUsername(rs.getString("username"));
				 user.setName(rs.getString("name"));
				 user.setUniversity(rs.getString("university"));
				 user.setDegree(rs.getString("degree"));
				 users.add(user);
			 }
			 rs.close();
			 statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return  users;
	}
	
	public List<User> getFollowedUsers(Long userId, Integer count) {
		 String query = "SELECT user.id, user.username, user.name, user.university, user.degree\r\n"
		 		+ "FROM user WHERE user.id IN (\r\n"
		 		+ "SELECT followed_id FROM follows WHERE follower_id = ?)\r\n"
		 		+ "ORDER BY user.username\r\n"
		 		+ "LIMIT ?;";
		 PreparedStatement statement = null;
		 List<User> users = new ArrayList<User>();
		 try {
			 statement = db.prepareStatement(query);
			 statement.setLong(1, userId);
			 statement.setInt(2, count);
			 ResultSet rs = statement.executeQuery();
			 while (rs.next()) {
				 User user = new User();
				 user.setId(rs.getLong("id"));
				 user.setUsername(rs.getString("username"));
				 user.setName(rs.getString("name"));
				 user.setUniversity(rs.getString("university"));
				 user.setDegree(rs.getString("degree"));
				 users.add(user);
			 }
			 rs.close();
			 statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return users;
	}
	
	public boolean isUserFollowingUser(Long followerId, Long followedId) {
		String query = "SELECT * from follows WHERE follower_id = ? AND followed_id = ?;";
		PreparedStatement statement = null;
		boolean output = false;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1, followerId);
			statement.setLong(2, followedId);
			ResultSet rs = statement.executeQuery();
			output = rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return output;
	}
	
	public Pair<Boolean,User> getUserByUsername(User user) {
		String query = "SELECT id, email, name, degree, country, birthday, position, is_admin FROM user WHERE username = ?";
		PreparedStatement statement = null;
		boolean output = false;
		try {
			statement = db.prepareStatement(query);
			statement.setString(1,user.getUsername());
			ResultSet rs = statement.executeQuery();
			if (rs.next()) {
				user.setId(rs.getLong("id"));
				user.setEmail(rs.getString("email"));
				user.setName(rs.getString("name"));
				user.setDegree(rs.getString("degree"));
				user.setCountry(rs.getString("country"));
				user.setBirthday(rs.getDate("birthday"));
				user.setPosition(rs.getString("position"));
				user.setIsAdmin(rs.getBoolean("is_admin"));
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
	

}