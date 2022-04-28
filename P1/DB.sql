# to initialize DB
DROP DATABASE IF EXISTS epaw;
CREATE DATABASE epaw; 
USE epaw;
CREATE TABLE user (
	nom VARCHAR(24),
	descripcio VARCHAR(255),
	id INTEGER NOT NULL AUTO_INCREMENT,
    telefon INTEGER,
	PRIMARY KEY (id) 
);

INSERT INTO user(nom, descripcio, telefon) VALUES
('Cristian','Admin','606343246'),
('Lucas','Admin','659433298'),
('Helena','Admin','693431232'),
('Mònica','Admin','623408090');

SELECT * FROM user;