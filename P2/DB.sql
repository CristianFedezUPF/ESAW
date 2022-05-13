DROP DATABASE lab2;
CREATE DATABASE lab2 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE lab2;

CREATE TABLE user (
	user_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(128) NOT NULl, 		
    username VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    gender ENUM('M', 'F', 'NB', 'NS'),
    university VARCHAR(255) NOT NULL,
    degree VARCHAR(255),
    country VARCHAR(64),
    birthday DATE,
    position ENUM('S', 'T'),
    image_path VARCHAR(255),
    salt VARCHAR(255)
);

USE lab2;
SELECT * FROM user;

SELECT username FROM user WHERE username = "Helena";
