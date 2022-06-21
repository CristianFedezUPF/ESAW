DROP SCHEMA IF EXISTS unitter;
CREATE DATABASE IF NOT EXISTS unitter
CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE unitter;

CREATE TABLE `user` (
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`name` VARCHAR(60) NOT NULl, 		
    username VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    gender ENUM('M', 'F', 'NB', 'NS'),
    university VARCHAR(255) NOT NULL,
    degree VARCHAR(255),
    country VARCHAR(64),
    birthday DATE,
    post_count INT DEFAULT 0,
    following_count INT DEFAULT 0,
    follower_count INT DEFAULT 0,
    like_count INT DEFAULT 0,
    `position` ENUM('S', 'T'),
    is_admin BOOLEAN DEFAULT false,
    image_path VARCHAR(255), 
    salt VARCHAR(255)
    
);
CREATE TABLE `follows` (
	follower_id BIGINT,
    followed_id BIGINT,
	creation_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, 
	FOREIGN KEY(follower_id) REFERENCES `user`(id),
    FOREIGN KEY(followed_id) REFERENCES `user`(id),
    PRIMARY KEY(follower_id, followed_id)
);


CREATE TABLE tweet (
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    parent_id BIGINT,
    user_id BIGINT NOT NULL,
    content VARCHAR(255) NOT NULL,
	creation_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    edit_timestamp DATETIME DEFAULT NULL,
    like_count INT DEFAULT 0,
	FOREIGN KEY(parent_id) REFERENCES tweet(id),
    FOREIGN KEY(user_id) REFERENCES `user`(id)
);

CREATE TABLE `like`(
	tweet_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
	creation_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY(tweet_id) REFERENCES tweet(id),
    FOREIGN KEY(user_id) REFERENCES `user`(id),
    PRIMARY KEY(tweet_id, user_id)
);

DELIMITER //
CREATE TRIGGER update_follow AFTER INSERT ON `follows`
	FOR EACH ROW
    BEGIN 
    UPDATE `user` SET `user`.follower_count = (`user`.follower_count + 1) WHERE `user`.id = NEW.followed_id;
    UPDATE `user` SET `user`.following_count = (`user`.following_count + 1) WHERE `user`.id = NEW.follower_id;
    END //
    DELIMITER ;

DELIMITER //
CREATE TRIGGER update_unfollow AFTER DELETE ON `follows`
	FOR EACH ROW
    BEGIN 
    UPDATE `user` SET `user`.follower_count = (`user`.follower_count - 1) WHERE `user`.id = OLD.followed_id;
    UPDATE `user` SET `user`.following_count = (`user`.following_count - 1) WHERE `user`.id = OLD.follower_id;
    END //
    DELIMITER ;

DELIMITER //
CREATE TRIGGER counter_post_added AFTER INSERT ON tweet
	FOR EACH ROW
    BEGIN 
    UPDATE `user` SET `user`.post_count = (`user`.post_count + 1) WHERE `user`.id = NEW.user_id;
    END //
    DELIMITER ;
    
DELIMITER //
CREATE TRIGGER counter_post_del AFTER DELETE ON tweet
	FOR EACH ROW
    BEGIN 
    UPDATE `user` SET `user`.post_count = (`user`.post_count - 1) WHERE `user`.id = OLD.user_id;
    END //
    DELIMITER ;

DELIMITER //
CREATE TRIGGER liked AFTER INSERT ON `like`
	FOR EACH ROW
    BEGIN 
    UPDATE `user` SET `user`.like_count = (`user`.post_count + 1) WHERE `user`.id =
		(SELECT user_id FROM tweet WHERE id = NEW.tweet_id);
    UPDATE tweet SET tweet.like_count = (tweet.like_count + 1) WHERE tweet.id = NEW.tweet_id;
    END //
    DELIMITER ;
    
DELIMITER //
CREATE TRIGGER disliked AFTER DELETE ON `like`
	FOR EACH ROW
    BEGIN 
    UPDATE `user` SET `user`.like_count = (`user`.post_count -1) WHERE `user`.id = 
		(SELECT user_id FROM tweet WHERE id = OLD.tweet_id);
    UPDATE tweet SET tweet.like_count = (tweet.like_count + 1) WHERE tweet.id = OLD.tweet_id;
    END //
    DELIMITER ;