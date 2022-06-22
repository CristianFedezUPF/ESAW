package services;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import models.Tweet;
import utils.DB;


public class TweetService {
	
	private DB db = null ;
	
	public TweetService() {
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
	
	/* Add a tweet */
	public void addTweet(Tweet tweet) {
		String query = "INSERT INTO tweet (user_id, content) VALUES (?,?)";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1,tweet.getUserId());
			statement.setString(2,tweet.getContent());
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// Edit tweet
	public void editTweet(Tweet tweet) {
		// TODO update query
		String query = "UPDATE tweet\r\n"
				+ "SET \r\n"
				+ "content = ?,\r\n"
				+ "edit_timestamp = NOW()\r\n"
				+ "WHERE id = ?;\r\n"
				+ "";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setString(1, tweet.getContent());
			statement.setLong(2, tweet.getId());
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/* Delete existing tweet */
	public void deleteTweet(Long tweetId) {
		String query = "DELETE FROM tweet WHERE id = ?;";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1, tweetId);
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public boolean checkIfRetweetExists(Long tweetId, Long userId) {
		String query = "SELECT * FROM retweet WHERE tweet_id = ? AND user_id = ?;";
		PreparedStatement statement = null;
		boolean output = true;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1, tweetId);
			statement.setLong(2, userId);
			ResultSet rs = statement.executeQuery();
			output = rs.next();
			rs.close();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return output;
	}
	
	public void addRetweet(Long tweetId, Long userId) {
		String query = "INSERT INTO retweet (tweet_id, user_id) VALUES (?,?)";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1, tweetId);
			statement.setLong(2, userId);
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void removeRetweet(Long tweetId, Long userId) {
		String query = "DELETE FROM retweet WHERE tweet_id = ? AND user_id = ?";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1, tweetId);
			statement.setLong(2, userId);
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public boolean checkIfLikeExists(Long tweetId, Long userId) {
		String query = "SELECT * FROM `like` WHERE tweet_id = ? AND user_id = ?;";
		PreparedStatement statement = null;
		boolean output = true;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1, tweetId);
			statement.setLong(2, userId);
			ResultSet rs = statement.executeQuery();
			output = rs.next();
			rs.close();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return output;
	}
	
	/* like a tweet*/
	public void addLike(Long tweetId, Long userId) {
		String query = "INSERT INTO `like` ( tweet_id, user_id) VALUES (?,?)";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1, tweetId);
			statement.setLong(2, userId);
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/* like a tweet*/
	public void removeLike(Long tweetId, Long userId) {
		String query = "DELETE FROM `like` WHERE tweet_id = ? AND user_id = ?";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1, tweetId);
			statement.setLong(2, userId);
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	/* Get tweets from a user given start and end*/
	public List<Tweet> getUserTweets(Long userId,Integer start, Integer end) {
		 String query = "SELECT tweet.id,tweet.user_id,tweet.creation_timestamp,tweet.edit_timestamp,tweet.content,"
		 		+ "tweet.like_count, tweet.retweet_count, user.username,user.name FROM tweet INNER JOIN user ON tweet.user_id = user.id where tweet.user_id = ? "
		 		+ "ORDER BY tweet.creation_timestamp DESC LIMIT ?,? ;";
		 PreparedStatement statement = null;
		 List<Tweet> tweets = new ArrayList<Tweet>();
		 try {
			 statement = db.prepareStatement(query);
			 statement.setLong(1,userId);
			 statement.setInt(2,start);
			 statement.setInt(3,end);
			 ResultSet rs = statement.executeQuery();
			 while (rs.next()) {
				 Tweet tweet = new Tweet();
      		     tweet.setId(rs.getLong("id"));
				 tweet.setUserId(rs.getLong("user_id"));
				 LocalDateTime then = rs.getObject("creation_timestamp", LocalDateTime.class);
				 LocalDateTime now = LocalDateTime.now();
				 tweet.setTimeSince(computeTimeSince(then, now));
				 LocalDateTime thenEdit = rs.getObject("edit_timestamp", LocalDateTime.class);
				 if (thenEdit != null) {
					 tweet.setEditTimeSince(computeTimeSince(thenEdit, now));
				 }
				 tweet.setContent(rs.getString("content"));
				 tweet.setUsername(rs.getString("username"));
				 tweet.setName(rs.getString("name"));
				 tweet.setLikeCount(rs.getInt("like_count"));
				 tweet.setRetweetCount(rs.getInt("retweet_count"));
				 tweets.add(tweet);
			 }
			 rs.close();
			 statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return tweets;
	}
	
	public List<Tweet> getGlobalTweets(Integer start, Integer end){
		String query = "SELECT tweet.id,tweet.user_id,tweet.creation_timestamp,tweet.edit_timestamp,tweet.content,"
				+ "tweet.like_count, tweet.retweet_count, user.username,user.name FROM tweet INNER JOIN user ON user.id = tweet.user_id"
				+ " ORDER BY tweet.creation_timestamp DESC LIMIT ?,?";
		PreparedStatement statement = null;
		List<Tweet> tweets = new ArrayList<Tweet>();
		try {
			 statement = db.prepareStatement(query);
			 statement.setInt(1,start);
			 statement.setInt(2,end);
			 ResultSet rs = statement.executeQuery();
			 while (rs.next()) {
				 Tweet tweet = new Tweet();
      		     tweet.setId(rs.getLong("id"));
				 tweet.setUserId(rs.getLong("user_id"));
				 LocalDateTime then = rs.getObject("creation_timestamp", LocalDateTime.class);
				 LocalDateTime now = LocalDateTime.now();
				 tweet.setTimeSince(computeTimeSince(then, now));
				 LocalDateTime thenEdit = rs.getObject("edit_timestamp", LocalDateTime.class);
				 if (thenEdit != null) {
					 tweet.setEditTimeSince(computeTimeSince(thenEdit, now));
				 }
				 tweet.setContent(rs.getString("content"));
				 tweet.setUsername(rs.getString("username"));
				 tweet.setName(rs.getString("name"));
				 tweet.setLikeCount(rs.getInt("like_count"));
				 tweet.setRetweetCount(rs.getInt("retweet_count"));
				 tweets.add(tweet);
			 }
			 rs.close();
			 statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return tweets;
	}
	
	public List<Tweet> getCustomTweets(Long userId, Integer start, Integer end){
		
		String query = "SELECT tweet.id, tweet.user_id, tweet.creation_timestamp, tweet.edit_timestamp, "
				+ "tweet.content, tweet.like_count,  tweet.retweet_count,"
				+ "user.username, user.name\r\n"
				+ "FROM tweet JOIN user ON tweet.user_id = user.id\r\n"
				+ "WHERE tweet.user_id IN \r\n"
				+ "(SELECT followed_id FROM follows WHERE follower_id = ?)\r\n"
				+ "OR tweet.user_id = ?\r\n"
				+ "ORDER BY tweet.creation_timestamp DESC LIMIT ?,?";
		PreparedStatement statement = null;
		List<Tweet> tweets = new ArrayList<Tweet>();
		try {
			 statement = db.prepareStatement(query);
			 statement.setLong(1, userId);
			 statement.setLong(2, userId);
			 statement.setInt(3,start);
			 statement.setInt(4,end);
			 ResultSet rs = statement.executeQuery();
			 while (rs.next()) {
				 Tweet tweet = new Tweet();
      		     tweet.setId(rs.getLong("id"));
				 tweet.setUserId(rs.getLong("user_id"));
				 LocalDateTime then = rs.getObject("creation_timestamp", LocalDateTime.class);
				 LocalDateTime now = LocalDateTime.now();
				 tweet.setTimeSince(computeTimeSince(then, now));
				 LocalDateTime thenEdit = rs.getObject("edit_timestamp", LocalDateTime.class);
				 if (thenEdit != null) {
					 tweet.setEditTimeSince(computeTimeSince(thenEdit, now));
				 }
				 tweet.setContent(rs.getString("content"));
				 tweet.setUsername(rs.getString("username"));
				 tweet.setName(rs.getString("name"));
				 tweet.setLikeCount(rs.getInt("like_count"));
				 tweet.setRetweetCount(rs.getInt("retweet_count"));
				 tweets.add(tweet);
			 }
			 rs.close();
			 statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return tweets;
	}
	
	private String computeTimeSince(LocalDateTime from, LocalDateTime to) {
		Long yearDiff = ChronoUnit.YEARS.between(from, to);
		if(yearDiff != 0) {
			return yearDiff.toString() + "Y";
		}
		Long monthDiff = ChronoUnit.MONTHS.between(from, to);
		if(monthDiff != 0) {
			return monthDiff.toString() + "M";
		}
		Long dayDiff = ChronoUnit.DAYS.between(from, to);
		if(dayDiff != 0) {
			return dayDiff.toString() + "d";
		}
		Long hourDiff = ChronoUnit.HOURS.between(from, to);
		if(hourDiff != 0) {
			return hourDiff.toString() + "h";
		}
		Long minuteDiff = ChronoUnit.MINUTES.between(from, to);
		if(minuteDiff != 0) {
			return minuteDiff.toString() + "m";
		}
		Long secondDiff = ChronoUnit.SECONDS.between(from, to);
		if(secondDiff != 0) {
			return secondDiff.toString() + "s";
		}
		return "Now";
		
		
	}
	
	
}