package models;

public class Tweet implements java.io.Serializable {

	 private static final long serialVersionUID = 1L;

	 private Long id;
	 private Long userId;
	 private String username;
	 private String name;
	 private String timeSince;
	 private String editTimeSince;
	 private String content;
	 private Integer likeCount;
	 private Boolean isLiked;

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
	 
	public String getEditTimeSince() {
		return editTimeSince;
	}

	public void setEditTimeSince(String editTimeSince) {
		this.editTimeSince = editTimeSince;
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

	public Boolean getIsLiked() {
		return isLiked;
	}

	public void setIsLiked(Boolean isLiked) {
		this.isLiked = isLiked;
	}

}