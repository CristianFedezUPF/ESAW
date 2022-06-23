DROP SCHEMA IF EXISTS unitter;
CREATE DATABASE IF NOT EXISTS unitter
CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE unitter;

CREATE TABLE `user` (
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`name` VARCHAR(50) NOT NULl, 		
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
    user_id BIGINT NOT NULL,
    content VARCHAR(200) NOT NULL,
	creation_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    edit_timestamp DATETIME DEFAULT NULL,
    like_count INT DEFAULT 0,
	retweet_count INT DEFAULT 0,
    FOREIGN KEY(user_id) REFERENCES `user`(id)ON DELETE CASCADE

);

CREATE TABLE `like`(
	tweet_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
	creation_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY(tweet_id) REFERENCES tweet(id) ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES `user`(id) ON DELETE CASCADE,
    PRIMARY KEY(tweet_id, user_id)
);

CREATE TABLE retweet(
	tweet_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
	creation_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY(tweet_id) REFERENCES tweet(id) ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES `user`(id) ON DELETE CASCADE,
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
CREATE TRIGGER on_add_like AFTER INSERT ON `like`
	FOR EACH ROW
    BEGIN 
    UPDATE `user` SET `user`.like_count = (`user`.like_count + 1) WHERE `user`.id =
		(SELECT user_id FROM tweet WHERE id = NEW.tweet_id);
    UPDATE tweet SET tweet.like_count = (tweet.like_count + 1) WHERE tweet.id = NEW.tweet_id;
    END //
    DELIMITER ;
    
DELIMITER //
CREATE TRIGGER on_remove_like AFTER DELETE ON `like`
	FOR EACH ROW
    BEGIN 
    UPDATE `user` SET `user`.like_count = (`user`.like_count - 1) WHERE `user`.id = 
		(SELECT user_id FROM tweet WHERE id = OLD.tweet_id);
    UPDATE tweet SET tweet.like_count = (tweet.like_count - 1) WHERE tweet.id = OLD.tweet_id;
    END //
    DELIMITER ;
    
DELIMITER //
CREATE TRIGGER on_add_retweet AFTER INSERT ON retweet
	FOR EACH ROW
    BEGIN 
    UPDATE tweet SET tweet.retweet_count = (tweet.retweet_count + 1) WHERE tweet.id = NEW.tweet_id;
    UPDATE `user` SET `user`.post_count = (`user`.post_count + 1) WHERE `user`.id = NEW.user_id;
    END //
    DELIMITER ;
    
DELIMITER //
CREATE TRIGGER on_remove_retweet AFTER DELETE ON retweet
	FOR EACH ROW
    BEGIN 
    UPDATE tweet SET tweet.retweet_count = (tweet.retweet_count - 1) WHERE tweet.id = OLD.tweet_id;
	UPDATE `user` SET `user`.post_count = (`user`.post_count - 1) WHERE `user`.id = OLD.user_id;
    END //
    DELIMITER ;
    

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

SELECT * FROM country;

DROP TABLE IF EXISTS university;

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


ALTER TABLE `user` AUTO_INCREMENT = 1;
ALTER TABLE tweet AUTO_INCREMENT = 1;


#pwd: ssssss
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Helena Pruna Craus','HelenaPruna','helena.pruna@estudiant.upf.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'F', 'Universitat Pompeu Fabra', 'Computer Science', 'Spain','2001-03-23', 'S', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', true); 
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Cristian Fernández Moreno','CristianFedez','cristianfedez03@estudiant.upf.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'M', 'Universitat Pompeu Fabra', 'Enginyeria de Sistemes Audiovisuals', 'Spain', '2001-07-30', 'S', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', true);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Lucas Damián Chindemi Santa Cruz','PatoLucas','lucasdamian.chindemi01@estudiant.upf.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'M', 'Universitat Pompeu Fabra', 'Computer', 'Argentina', '1999-3-1', 'S', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', true);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Monica Grau','moni','monica.grau02@estudiant.upf.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'F', 'Universitat Pompeu Fabra', 'Computer Science', 'Spain', '2001-02-20', 'S', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', true);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Maria Torres','meri','maria.torres04@estudiant.url.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'F', 'Universitat Ramon Llull', 'Marqueting i relacions públiques', 'Spain', '2001-05-12', 'S', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', false);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Queralt Poch','poch','queralt.poch01@estudiant.url.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'F', 'Universitat Ramon Llull', 'Farmàcia i Nutrició', 'Spain', '2001-11-13', 'S', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', false);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Laia Rodriguez','Laia','laia.rodriguez02@estudiant.uab.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'F', 'Universitat Autònoma de Barcelona', 'Filologia anglesa i catalana', 'Spain', '2001-10-14', 'S', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', false);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Eulalia Craus Vidal','eulaCraus','eulalia.craus01@estudiant.url.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'F', 'Universitat Ramon Llull', 'Relacions internacionals', 'Spain', '2001-03-21', 'S', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', false);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Miquel Vázquez Rius','MiquelViR','miquel.vazquez02@estudiant.upf.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'M', 'Universitat Pompeu Fabra', 'Enginyeria de Sistemes Audiovisuals', 'Spain', '2001-01-31', 'S', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', false);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Carlota Julià','Charlotte','carlota.julia01@estudiant.upf.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú',
    'F', 'Universitat Pompeu Fabra', 'Mathematical Engineering in Data Science', 'Spain','2002-11-24', 'S', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', false);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Klaus Ditterich Martín','Klaus','Klaus.ditterich01@estudiant.upf.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'M', 'Universitat Pompeu Fabra', 'Telecommunications Network Engineering', 'Spain', '2001-11-05', 'S', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', false);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Alex Pruna Craus','AlexPruCra','alex.pruna01@estudiant.uoc.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'M', 'Universitat Oberta de Catalunya', 'ADE', 'Spain', '1994-08-25', 'S', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', false);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Jordi Taixes','Taixes','jordi.taixes@upf.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'M', 'Universitat Pompeu Fabra', NULL, 'Spain', NULL, 'T', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', false);  
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Patricia Santos Rodriguez','PatriciaSR','Patricia.santos@upf.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'F', 'Universitat Pompeu Fabra', NULL, 'Spain', NULL, 'T', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', false);  
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Oriol Martinez Pujol','Oriol','oriol.martinez@upf.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'M', 'Universitat Pompeu Fabra', NULL, 'Spain', NULL, 'T', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', false);  
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, is_admin) VALUES ('Juan Antonio Rodríguez García','Joan','juanantonio.rodriguez@upf.edu', '_£»I%ÒiueÍ×@ØÝ8Úz[ÎÊÜ^±lÌianú', 
    'M', 'Universitat Pompeu Fabra', NULL, 'Spain', '1992-03-15', 'T', NULL, '@ÝÎ-iÿ©öüÅÇVÆw', false);  


INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 3);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 4);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 5);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 6);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 7);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 8);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 9);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 10);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 11);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 15);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 16);

INSERT INTO `follows`(follower_id, followed_id) VALUES(2, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(2, 3);
INSERT INTO `follows`(follower_id, followed_id) VALUES(2, 4);
INSERT INTO `follows`(follower_id, followed_id) VALUES(2, 9);
INSERT INTO `follows`(follower_id, followed_id) VALUES(2, 10);
INSERT INTO `follows`(follower_id, followed_id) VALUES(2, 11);
INSERT INTO `follows`(follower_id, followed_id) VALUES(2, 14);
INSERT INTO `follows`(follower_id, followed_id) VALUES(2, 15);
INSERT INTO `follows`(follower_id, followed_id) VALUES(2, 16);

INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 4);
INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 9);
INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 10);
INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 11);
INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 13);
INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 14);

INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 3);
INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 10);
INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 11);
INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 13);
INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 14);
INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 15);
INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 16);

INSERT INTO `follows`(follower_id, followed_id) VALUES(5, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(5, 6);
INSERT INTO `follows`(follower_id, followed_id) VALUES(5, 7);

INSERT INTO `follows`(follower_id, followed_id) VALUES(6, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(6, 5);
INSERT INTO `follows`(follower_id, followed_id) VALUES(6, 7);

INSERT INTO `follows`(follower_id, followed_id) VALUES(7, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(7, 5);
INSERT INTO `follows`(follower_id, followed_id) VALUES(7, 6);

INSERT INTO `follows`(follower_id, followed_id) VALUES(8, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(8, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(8, 12);
INSERT INTO `follows`(follower_id, followed_id) VALUES(8, 13);

INSERT INTO `follows`(follower_id, followed_id) VALUES(9, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(9, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(9, 3);
INSERT INTO `follows`(follower_id, followed_id) VALUES(9, 4);
INSERT INTO `follows`(follower_id, followed_id) VALUES(9, 10);
INSERT INTO `follows`(follower_id, followed_id) VALUES(9, 11);
INSERT INTO `follows`(follower_id, followed_id) VALUES(9, 13);
INSERT INTO `follows`(follower_id, followed_id) VALUES(9, 14);

INSERT INTO `follows`(follower_id, followed_id) VALUES(10, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(10, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(10, 3);
INSERT INTO `follows`(follower_id, followed_id) VALUES(10, 4);
INSERT INTO `follows`(follower_id, followed_id) VALUES(10, 9);
INSERT INTO `follows`(follower_id, followed_id) VALUES(10, 11);
INSERT INTO `follows`(follower_id, followed_id) VALUES(10, 13);
INSERT INTO `follows`(follower_id, followed_id) VALUES(10, 14);

INSERT INTO `follows`(follower_id, followed_id) VALUES(11, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(11, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(11, 3);
INSERT INTO `follows`(follower_id, followed_id) VALUES(11, 4);
INSERT INTO `follows`(follower_id, followed_id) VALUES(11, 9);
INSERT INTO `follows`(follower_id, followed_id) VALUES(11, 10);
INSERT INTO `follows`(follower_id, followed_id) VALUES(11, 13);

INSERT INTO `follows`(follower_id, followed_id) VALUES(12, 8);

INSERT INTO `follows`(follower_id, followed_id) VALUES(13, 8);
INSERT INTO `follows`(follower_id, followed_id) VALUES(13, 9);
INSERT INTO `follows`(follower_id, followed_id) VALUES(13, 14);
INSERT INTO `follows`(follower_id, followed_id) VALUES(13, 15);

INSERT INTO `follows`(follower_id, followed_id) VALUES(14, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(14, 13);
INSERT INTO `follows`(follower_id, followed_id) VALUES(14, 16);

INSERT INTO `follows`(follower_id, followed_id) VALUES(15, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(15, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(15, 3);
INSERT INTO `follows`(follower_id, followed_id) VALUES(15, 4);
INSERT INTO `follows`(follower_id, followed_id) VALUES(15, 13);
INSERT INTO `follows`(follower_id, followed_id) VALUES(15, 14);
INSERT INTO `follows`(follower_id, followed_id) VALUES(15, 16);

INSERT INTO `follows`(follower_id, followed_id) VALUES(16, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(16, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(16, 3);
INSERT INTO `follows`(follower_id, followed_id) VALUES(16, 4);
INSERT INTO `follows`(follower_id, followed_id) VALUES(16, 13);
INSERT INTO `follows`(follower_id, followed_id) VALUES(16, 15);
INSERT INTO `follows`(follower_id, followed_id) VALUES(16, 16);





INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-01 15:01:53", 1, 'Hello im Helena!!');
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2021-06-01 09:01:53", 4, 'Hello im Moni!!');
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-01 15:01:43", 10, 'Hello im Carlota!!');
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2021-12-15 20:01:23", 15, 'Hello im Oriol!!');
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-01 15:01:33", 11, 'Hello im Klaus!!');
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-03 15:03:53", 2, 'Hello im Cristian!!');
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-09 21:00:53", 13, "Avui han sortit les entrades per les representacions de nine per part del grup d'adults d'aules CORREU A COMPRAR-LES!!");
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-17 15:37:46", 13, "Les entrades per les sessions d'avui de NINE estan esgotades!! però encara teniu oportunitat d'aconseguir-ne per demà :) ");
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-19 21:00:53", 13, "L'obra ha sortit genial noies!! molt bon treball!!");
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-15 15:12:53", 2, "Today I saw Jurassic World: Dominion in IMAX 3D at Diagonal Mar, it was great!");
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-15 15:14:53", 2, "My next stop at the cinema will be Lightyear after the exams, I'm excited for it!");
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-22 20:04:30", 11, "TICs exam of today was so unfairly hard :( they need to make the exams in line with the theory/exercises given by the teachers. ");
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-23 14:32:53", 1, "IN THIS UNIVERSITY WE LOVE KITTENS.");
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-18 14:02:53", 6, "IVE ACED MY EXAMS!!!");
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-20 20:29:53", 5, "this project is killing me :((");
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-21 20:02:53", 3, 'Computer science is superior');
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-16 19:12:53", 15, 'Els meus alumnes estan creant uns Twitters increibles!!');
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-04 09:42:53", 4, 'La millor assignatura es algebra');
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-20 18:54:53", 11, 'Telecos es lo mejor que he hecho en el mundo');
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-20 18:55:53", 11, 'Quiero trabajar ya con antenas /s');



INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('2', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('2', '3');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('4', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('6', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('6', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('17', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('14', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('19', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('20', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('16', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('19', '2');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('13', '2');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('20', '2');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('2', '3');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('15', '3');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('12', '3');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('17', '3');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('16', '4');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('12', '4');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('17', '4');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('14', '5');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('13', '5');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('1', '5');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('1', '6');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('1', '7');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('14', '7');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('1', '7');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('17', '16');


INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-04 15:22:53", '6', '1');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-10 15:15:03", '18', '1');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-10 00:49:53", '7', '8');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-17 16:13:53", '8', '8');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-19 21:13:53", '9', '8');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-21 00:49:53", '15', '3');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-23 23:24:33", '13', '2');