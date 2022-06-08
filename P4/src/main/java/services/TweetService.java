package services;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
		// TODO update query
		String query = "INSERT INTO tweets (uid,postdatetime,content) VALUES (?,?,?)";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1,tweet.getUserId());
			statement.setTimestamp(2,tweet.getPostDateTime());
			statement.setString(3,tweet.getContent());
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/* Delete existing tweet */
	public void deleteTweet(Long long1,Long long2) {
		// TODO update query
		String query = "DELETE FROM tweets WHERE id = ? AND uid=?";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setLong(1,long1);
			statement.setLong(2,long2);
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	/* Get tweets from a user given start and end*/
	public List<Tweet> getUserTweets(Long userId,Integer start, Integer end) {
		 String query = "SELECT tweet.id,tweet.user_id,tweet.date,tweet.content,user.username,user.name FROM tweet INNER JOIN user ON tweet.user_id = user.id where tweet.user_id = ? ORDER BY tweet.date DESC LIMIT ?,? ;";
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
				 tweet.setPostDateTime(rs.getTimestamp("date"));
				 tweet.setContent(rs.getString("content"));
				 tweet.setUsername(rs.getString("username"));
				 tweet.setName(rs.getString("name"));;
				 tweets.add(tweet);
			 }
			 rs.close();
			 statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return tweets;
	}
	
	public List<Tweet> getTweets(Integer start, Integer end){
		String query = "SELECT tweet.id,tweet.user_id,tweet.date,tweet.content,user.username,user.name FROM tweet INNER JOIN user ON user.id = tweet.user_id ORDER BY tweet.date DESC LIMIT ?,?";
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
				 tweet.setPostDateTime(rs.getTimestamp("date"));
				 tweet.setContent(rs.getString("content"));
				 tweet.setUsername(rs.getString("username"));
				 tweet.setName(rs.getString("name"));
				 tweets.add(tweet);
			 }
			 rs.close();
			 statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return tweets;
	}
	
	
}