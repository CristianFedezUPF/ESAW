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
	FOREIGN KEY(follower_id) REFERENCES `user`(id) ON DELETE CASCADE,
    FOREIGN KEY(followed_id) REFERENCES `user`(id) ON DELETE CASCADE,
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
	FOREIGN KEY(parent_id) REFERENCES tweet(id) ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES `user`(id)ON DELETE CASCADE

);

CREATE TABLE `like`(
	tweet_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
	creation_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY(tweet_id) REFERENCES tweet(id) ON UPDATE CASCADE,
    FOREIGN KEY(user_id) REFERENCES `user`(id) ON UPDATE CASCADE,
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
    
ALTER TABLE `user` AUTO_INCREMENT = 1;
ALTER TABLE tweet AUTO_INCREMENT = 1;


#pwd: ssssss
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Anna Pruna Craus','AnnaPruna','anna.pruna@gmail.com', 'Y4à=Ó3*ÉRcñqy6j`Ácæ³­ÔÞ=', 'NB', 'Universitat Pompeu Fabra', NULL, 'Spain','1997-1-1', 
    'T', NULL, "ÝZ)lmVÁtã´Ú", false);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Helena Pruna Craus','HelenaPruna','helena.pruna@gmail.com', '¼³PÌáI±³NÎ¼EÀÑÚÐæ8^Jp¬¶á', 'F', 'UPF', 'Computer Science', 'Spain','2001-03-23',
    'S', NULL, '(hS5rmçg àòÉ', true); 
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Cristian Fernández Moreno','CristianFedez','cristianfedez@gmail.com', 'Ü|xªGTûßÕ_¼-Ì®-Vg¢wSPÇgöÔFÊ8', 'M', 'Universitat Pompeu Fabra', 'Enginyeria de Sistemes Audiovisuals', 'Spain',
    '2001-07-30', 'S', NULL, 'uXpÐÚïÓI½SÄR0f%', true);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Lucas Damián Chindemi Santa Cruz','PatoLucas','lucas.chindemi@gmail.com', 'nR²¶êLðùR
Êø³üÏ¹¯¥ûlHÁS®', 'M', 'UPF', 'Computer', 
    'Argentina', '1999-3-1', 'S', NULL, '9û>íue ©.²;[=', true);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Moni','moni','moni01@gmail.com', 'xUh·Z7âU³¢2yù$öäg¶åáhéþì', 'F', 'Universitat Pompeu Fabra', 'Computer Science', 'Spain',
    '2001-02-20', 'S', NULL, '?ïÛ¨:6±¥­p', true);
    INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Moni','moni2','moni02@gmail.com', 'xUh·Z7âU³¢2yù$öäg¶åáhéþì', 'F', 'Universitat Pompeu Fabra', 'Computer Science', 'Spain',
    '2001-02-20', 'S', NULL, '?ïÛ¨:6±¥­p', true);
    INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Moni','moni3','moni03@gmail.com', 'xUh·Z7âU³¢2yù$öäg¶åáhéþì', 'F', 'Universitat Pompeu Fabra', 'Computer Science', 'Spain',
    '2001-02-20', 'S', NULL, '?ïÛ¨:6±¥­p', true);
    INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Moni','moni4','moni04@gmail.com', 'xUh·Z7âU³¢2yù$öäg¶åáhéþì', 'F', 'Universitat Pompeu Fabra', 'Computer Science', 'Spain',
    '2001-02-20', 'S', NULL, '?ïÛ¨:6±¥­p', true);
    INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Moni','moni5','moni05@gmail.com', 'xUh·Z7âU³¢2yù$öäg¶åáhéþì', 'F', 'Universitat Pompeu Fabra', 'Computer Science', 'Spain',
    '2001-02-20', 'S', NULL, '?ïÛ¨:6±¥­p', true);
    INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Moni','moni6','moni06@gmail.com', 'xUh·Z7âU³¢2yù$öäg¶åáhéþì', 'F', 'Universitat Pompeu Fabra', 'Computer Science', 'Spain',
    '2001-02-20', 'S', NULL, '?ïÛ¨:6±¥­p', true);
    INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Moni','moni7','moni07@gmail.com', 'xUh·Z7âU³¢2yù$öäg¶åáhéþì', 'F', 'Universitat Pompeu Fabra', 'Computer Science', 'Spain',
    '2001-02-20', 'S', NULL, '?ïÛ¨:6±¥­p', true);
    INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Moni','moni8','moni08@gmail.com', 'xUh·Z7âU³¢2yù$öäg¶åáhéþì', 'F', 'Universitat Pompeu Fabra', 'Computer Science', 'Spain',
    '2001-02-20', 'S', NULL, '?ïÛ¨:6±¥­p', true);


INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 4);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 4);
INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 5);
INSERT INTO `follows`(follower_id, followed_id) VALUES(2, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 1);


INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 1, 'hello im Anna');
INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 3, 'hello im Cristian and Helena is my best friend');
INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 3, 'nah it\'s totally false lmao');
INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 3, 'jkjk ly Helena');
INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 3, "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.");
INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 3, "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.");
INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 3, "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.");
INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 3, "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.");
INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 3, "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.");
INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 3, "jose juan");
INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 4, 'Computer science is superior');

INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('2', '2');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('4', '2');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('3', '4');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('4', '5');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('1', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('7', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('8', '1');

CREATE TABLE country(
	continent VARCHAR(12),
    code VARCHAR(3) ,
    name VARCHAR(60), 
    PRIMARY KEY(code)
);

INSERT INTO country(continent, code, name) VALUES ('Africa',            "DZ" , 'Algeria');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "AO" , 'Angola');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "BJ" , 'Benin');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "BW" , 'Botswana');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "BF" , 'Burkina Faso');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "BI" , 'Burundi');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "CM" , 'Cameroon');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "CV" , 'Cape Verde');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "CF" , 'Central African Republic');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "TD" , 'Chad');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "KM" , 'Comoros');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "CG" , 'Congo - Brazzaville');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "CD" , 'Congo - Kinshasa');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "CI" , 'Côte d’Ivoire');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "DJ" , 'Djibouti');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "EG" , 'Egypt');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "GQ" , 'Equatorial Guinea');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ER" , 'Eritrea');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ET" , 'Ethiopia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "GA" , 'Gabon');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "GM" , 'Gambia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "GH" , 'Ghana');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "GN" , 'Guinea');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "GW" , 'Guinea-Bissau');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "KE" , 'Kenya');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "LS" , 'Lesotho');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "LR" , 'Liberia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "LY" , 'Libya');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "MG" , 'Madagascar');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "MW" , 'Malawi');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ML" , 'Mali');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "MR" , 'Mauritania');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "MU" , 'Mauritius');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "YT" , 'Mayotte');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "MA" , 'Morocco');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "MZ" , 'Mozambique');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "NA" , 'Namibia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "NE" , 'Niger');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "NG" , 'Nigeria');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "RW" , 'Rwanda');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "RE" , 'Réunion');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SH" , 'Saint Helena');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SN" , 'Senegal');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SC" , 'Seychelles');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SL" , 'Sierra Leone');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SO" , 'Somalia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ZA" , 'South Africa');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SD" , 'Sudan');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SZ" , 'Swaziland');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ST" , 'São Tomé and Príncipe');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "TZ" , 'Tanzania');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "TG" , 'Togo');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "TN" , 'Tunisia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "UG" , 'Uganda');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "EH" , 'Western Sahara');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ZM" , 'Zambia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ZW" , 'Zimbabwe');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "AI" , 'Anguilla');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "AG" , 'Antigua and Barbuda');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "AR" , 'Argentina');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "AW" , 'Aruba');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BS" , 'Bahamas');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BB" , 'Barbados');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BZ" , 'Belize');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BM" , 'Bermuda');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BO" , 'Bolivia');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BR" , 'Brazil');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "VG" , 'British Virgin Islands');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "CA" , 'Canada');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "KY" , 'Cayman Islands');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "CL" , 'Chile');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "CO" , 'Colombia');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "CR" , 'Costa Rica');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "CU" , 'Cuba');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "DM" , 'Dominica');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "DO" , 'Dominican Republic');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "EC" , 'Ecuador');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "SV" , 'El Salvador');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "FK" , 'Falkland Islands');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "GF" , 'French Guiana');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "GL" , 'Greenland');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "GD" , 'Grenada');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "GP" , 'Guadeloupe');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "GT" , 'Guatemala');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "GY" , 'Guyana');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "HT" , 'Haiti');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "HN" , 'Honduras');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "JM" , 'Jamaica');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "MQ" , 'Martinique');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "MX" , 'Mexico');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "MS" , 'Montserrat');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "AN" , 'Netherlands Antilles');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "NI" , 'Nicaragua');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "PA" , 'Panama');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "PY" , 'Paraguay');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "PE" , 'Peru');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "PR" , 'Puerto Rico');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BL" , 'Saint Barthélemy');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "KN" , 'Saint Kitts and Nevis');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "LC" , 'Saint Lucia');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "MF" , 'Saint Martin');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "PM" , 'Saint Pierre and Miquelon');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "VC" , 'Saint Vincent and the Grenadines');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "SR" , 'Suriname');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "TT" , 'Trinidad and Tobago');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "TC" , 'Turks and Caicos Islands');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "VI" , 'U.S. Virgin Islands');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "US" , 'United States');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "UY" , 'Uruguay');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "VE" , 'Venezuela');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "AF" , 'Afghanistan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "AM" , 'Armenia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "AZ" , 'Azerbaijan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "BH" , 'Bahrain');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "BD" , 'Bangladesh');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "BT" , 'Bhutan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "BN" , 'Brunei');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "KH" , 'Cambodia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "CN" , 'China');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "GE" , 'Georgia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "HK" , 'Hong Kong SAR China');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "IN" , 'India');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "ID" , 'Indonesia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "IR" , 'Iran');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "IQ" , 'Iraq');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "IL" , 'Israel');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "JP" , 'Japan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "JO" , 'Jordan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "KZ" , 'Kazakhstan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "KW" , 'Kuwait');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "KG" , 'Kyrgyzstan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "LA" , 'Laos');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "LB" , 'Lebanon');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "MO" , 'Macau SAR China');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "MY" , 'Malaysia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "MV" , 'Maldives');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "MN" , 'Mongolia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "MM" , 'Myanmar [Burma]');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "NP" , 'Nepal');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "NT" , 'Neutral Zone');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "KP" , 'North Korea');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "OM" , 'Oman');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "PK" , 'Pakistan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "PS" , 'Palestinian Territories');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "YD" , 'People\'s Democratic Republic of Yemen');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "PH" , 'Philippines');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "QA" , 'Qatar');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "SA" , 'Saudi Arabia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "SG" , 'Singapore');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "KR" , 'South Korea');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "LK" , 'Sri Lanka');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "SY" , 'Syria');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "TW" , 'Taiwan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "TJ" , 'Tajikistan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "TH" , 'Thailand');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "TL" , 'Timor-Leste');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "TR" , 'Turkey');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "TM" , 'Turkmenistan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "AE" , 'United Arab Emirates');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "UZ" , 'Uzbekistan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "VN" , 'Vietnam');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "YE" , 'Yemen');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "AL" , 'Albania');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "AD" , 'Andorra');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "AT" , 'Austria');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "BY" , 'Belarus');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "BE" , 'Belgium');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "BA" , 'Bosnia and Herzegovina');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "BG" , 'Bulgaria');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "HR" , 'Croatia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "CY" , 'Cyprus');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "CZ" , 'Czech Republic');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "DK" , 'Denmark');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "DD" , 'East Germany');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "EE" , 'Estonia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "FO" , 'Faroe Islands');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "FI" , 'Finland');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "FR" , 'France');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "DE" , 'Germany');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "GI" , 'Gibraltar');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "GR" , 'Greece');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "GG" , 'Guernsey');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "HU" , 'Hungary');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "IS" , 'Iceland');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "IE" , 'Ireland');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "IM" , 'Isle of Man');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "IT" , 'Italy');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "JE" , 'Jersey');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "LV" , 'Latvia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "LI" , 'Liechtenstein');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "LT" , 'Lithuania');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "LU" , 'Luxembourg');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "MK" , 'Macedonia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "MT" , 'Malta');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "FX" , 'Metropolitan France');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "MD" , 'Moldova');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "MC" , 'Monaco');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "ME" , 'Montenegro');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "NL" , 'Netherlands');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "NO" , 'Norway');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "PL" , 'Poland');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "PT" , 'Portugal');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "RO" , 'Romania');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "RU" , 'Russia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "SM" , 'San Marino');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "RS" , 'Serbia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "CS" , 'Serbia and Montenegro');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "SK" , 'Slovakia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "SI" , 'Slovenia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "ES" , 'Spain');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "SJ" , 'Svalbard and Jan Mayen');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "SE" , 'Sweden');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "CH" , 'Switzerland');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "UA" , 'Ukraine');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "SU" , 'Union of Soviet Socialist Republics');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "GB" , 'United Kingdom');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "VA" , 'Vatican City');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "AX" , 'Åland Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "AS" , 'American Samoa');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "AQ" , 'Antarctica');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "AU" , 'Australia');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "BV" , 'Bouvet Island');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "IO" , 'British Indian Ocean Territory');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "CX" , 'Christmas Island');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "CC" , 'Cocos [Keeling] Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "CK" , 'Cook Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "FJ" , 'Fiji');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "PF" , 'French Polynesia');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "TF" , 'French Southern Territories');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "GU" , 'Guam');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "HM" , 'Heard Island and McDonald Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "KI" , 'Kiribati');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "MH" , 'Marshall Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "FM" , 'Micronesia');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "NR" , 'Nauru');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "NC" , 'New Caledonia');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "NZ" , 'New Zealand');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "NU" , 'Niue');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "NF" , 'Norfolk Island');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "MP" , 'Northern Mariana Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "PW" , 'Palau');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "PG" , 'Papua New Guinea');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "PN" , 'Pitcairn Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "WS" , 'Samoa');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "SB" , 'Solomon Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "GS" , 'South Georgia and the South Sandwich Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "TK" , 'Tokelau');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "TO" , 'Tonga');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "TV" , 'Tuvalu');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "UM" , 'U.S. Minor Outlying Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "VU" , 'Vanuatu');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "WF" , 'Wallis and Futuna');

CREATE TABLE university(
	code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(60)
);

INSERT INTO university( code, name) VALUES ('UB', 'Universitat de Barcelona');
INSERT INTO university( code, name) VALUES ('UPF', 'Universitat Pompeu Fabra');
INSERT INTO university( code, name) VALUES ('UAB', 'Universitat Autònoma de Barcelona');
INSERT INTO university( code, name) VALUES ('UdL', 'Universitat de Lleida');
INSERT INTO university( code, name) VALUES ('UdG', 'Universitat de Girona');
INSERT INTO university( code, name) VALUES ('URV', 'Universitat Rovira i Virgili');
INSERT INTO university( code, name) VALUES ('UOC', 'Universitat Oberta de Catalunya');
INSERT INTO university( code, name) VALUES ('URL', 'Universitat Ramon Llull');
INSERT INTO university( code, name) VALUES ('Uvic', 'Universitat de Vic');
INSERT INTO university( code, name) VALUES ('UIC', 'Universitat Internacional de Catalunya');
INSERT INTO university( code, name) VALUES ('UAO-CEU', 'Universitat Abat Oliba');