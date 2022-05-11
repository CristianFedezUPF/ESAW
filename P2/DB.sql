#DROP DATABASE lab2;
CREATE DATABASE lab2;
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
    type ENUM('S', 'T'),
    image_path VARCHAR(255)
);

USE lab2;
SELECT * FROM users;