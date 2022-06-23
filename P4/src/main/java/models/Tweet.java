package models;

public class Tweet implements java.io.Serializable {

	 private static final long serialVersionUID = 1L;

	 private Long id;
	 private Long userId;
	 private String username;
	 private String name;
	 private String timeSince;
	 private String timeSinceEdit;
	 private String content;
	 private Integer likeCount;
	 private Integer retweetCount;
	 private Boolean isLiked;
	 private Boolean isRetweeted;
	 private Long retweetUserId;
	 private String retweetUserName;
	 private String timeSinceRetweet;

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
	 
	public String getTimeSinceEdit() {
		return timeSinceEdit;
	}

	public void setTimeSinceEdit(String timeSinceEdit) {
		this.timeSinceEdit = timeSinceEdit;
	}

	public String getContent() {
		 return this.content;
	 }
	 public void setContent(String content) {
		 this.content = content;
	 }
	 
	 public Integer getLikeCount() {
		return this.likeCount;
	}
		
	public void setLikeCount(Integer count) {
		this.likeCount = count;
	}
	
	public Integer getRetweetCount() {
		return this.retweetCount;
	}
	
	public void setRetweetCount(Integer count) {
		this.retweetCount = count;
	}
	

	public Boolean getIsLiked() {
		return isLiked;
	}

	public void setIsLiked(Boolean isLiked) {
		this.isLiked = isLiked;
	}

	public Boolean getIsRetweeted() {
		return isRetweeted;
	}

	public void setIsRetweeted(Boolean isRetweeted) {
		this.isRetweeted = isRetweeted;
	}

	public Long getRetweetUserId() {
		return retweetUserId;
	}

	public void setRetweetUserId(Long retweetUserId) {
		this.retweetUserId = retweetUserId;
	}

	public String getRetweetUserName() {
		return retweetUserName;
	}

	public void setRetweetUserName(String retweetUserName) {
		this.retweetUserName = retweetUserName;
	}

	public String getTimeSinceRetweet() {
		return timeSinceRetweet;
	}

	public void setTimeSinceRetweet(String timeSinceRetweet) {
		this.timeSinceRetweet = timeSinceRetweet;
	}

}