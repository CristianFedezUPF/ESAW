DROP SCHEMA IF EXISTS lab3;
CREATE DATABASE IF NOT EXISTS lab3;
USE lab3;

DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS tweet;
DROP TABLE IF EXISTS `following`;

CREATE TABLE `user` (
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`name` VARCHAR(128) NOT NULl, 		
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
    `position` ENUM('S', 'T'),
    image_path VARCHAR(255), 
    salt VARCHAR(255)
    
);
CREATE TABLE `following` (
	follower_id BIGINT,
    followed_id BIGINT,
    `date` DATETIME DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY(follower_id) REFERENCES `user`(id),
    FOREIGN KEY(followed_id) REFERENCES `user`(id),
    PRIMARY KEY(follower_id, followed_id)
);


CREATE TABLE tweet (
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    parent_id BIGINT,
    user_id BIGINT NOT NULL,
    content VARCHAR(255) NOT NULL,
    `date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(parent_id) REFERENCES tweet(id),
    FOREIGN KEY(user_id) REFERENCES `user`(id)
);

DROP TRIGGER IF EXISTS update_follow;
DELIMITER //
CREATE TRIGGER update_follow AFTER INSERT ON `following`
	FOR EACH ROW
    BEGIN 
    UPDATE `user` SET `user`.follower_count = (`user`.follower_count + 1) WHERE `user`.id = NEW.followed_id;
    UPDATE `user` SET `user`.following_count = (`user`.following_count + 1) WHERE `user`.id = NEW.follower_id;
    END //
    DELIMITER ;
    
DROP TRIGGER IF EXISTS counter_post;
DELIMITER //
CREATE TRIGGER counter_post AFTER INSERT ON tweet
	FOR EACH ROW
    BEGIN 
    UPDATE `user` SET `user`.post_count = (`user`.post_count + 1) WHERE `user`.id = NEW.user_id;
    END //
    DELIMITER ;