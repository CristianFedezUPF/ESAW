package models;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class Tweet implements java.io.Serializable {

	 private static final long serialVersionUID = 1L;

	 private Long id;
	 private Long userId;
	 private String username;
	 private String name;
	 private String timeSince;
	 private String content;

	 public Tweet() {
	 }

	 public Long getId() {
		 return this.id;
	 }
	 
	 public void setId(Long id) {
		 this.id = id;
	 }

	 public Long getUserId() {
		 return this.userId;
	 }
	 
	 public void setUserId(Long userId) {
		 this.userId = userId;
	 }
	 
	 public String getUsername() {
		 return this.username;
	 }
	 
	 public void setUsername(String username) {
		 this.username = username;
	 }
	 
	 public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTimeSince() {
		 return this.timeSince;
	 }
	 public void setTimeSince(String timeSince) {
		 this.timeSince = timeSince;
	 }
	 
	 public String getContent() {
		 return this.content;
	 }
	 public void setContent(String content) {
		 this.content = content;
	 }

}