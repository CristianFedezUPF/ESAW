DROP SCHEMA IF EXISTS unitter;
CREATE DATABASE IF NOT EXISTS unitter
CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE unitter;


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
    admin BOOLEAN DEFAULT false,
    image_path VARCHAR(255), 
    salt VARCHAR(255)
    
);
CREATE TABLE `follows` (
	follower_id BIGINT,
    followed_id BIGINT,
    create_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, 
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
    FOREIGN KEY(parent_id) REFERENCES tweet(id),
    FOREIGN KEY(user_id) REFERENCES `user`(id)
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
CREATE TRIGGER counter_post AFTER INSERT ON tweet
	FOR EACH ROW
    BEGIN 
    UPDATE `user` SET `user`.post_count = (`user`.post_count + 1) WHERE `user`.id = NEW.user_id;
    END //
    DELIMITER ;