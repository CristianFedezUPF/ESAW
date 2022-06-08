package models;
import java.sql.Timestamp;

public class Tweet implements java.io.Serializable {

	 private static final long serialVersionUID = 1L;

	 private Long id;
	 private Long userId;
	 private String username;
	 private String name;
	 private Timestamp postDateTime;
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
	 
	 public void setUserId(Long uid) {
		 this.userId = uid;
	 }
	 
	 public String getUsername() {
		 return this.username;
	 }
	 
	 public void setUsername(String uname) {
		 this.username = uname;
	 }
	 
	 public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Timestamp getPostDateTime() {
		 return this.postDateTime;
	 }
	 public void setPostDateTime(Timestamp postDateTime) {
		 this.postDateTime = postDateTime;
	 }
	 
	 public String getContent() {
		 return this.content;
	 }
	 public void setContent(String content) {
		 this.content = content;
	 }

}