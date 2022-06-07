USE lab3; 

ALTER TABLE `user` AUTO_INCREMENT = 1;
ALTER TABLE tweet AUTO_INCREMENT = 1;



INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt) VALUES ('Anna','Anna','anna.pruna01@gmail.com', 'ssssss', 'NB', 'UPF', NULL, 'Spain','1997-1-1', 
    'T', NULL, NULL);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt) VALUES ('a','b','b.pruna01@gmail.com', '4', 'NS', 'UPF', 'Computer', 'Spain','2003-1-1', 
    'S', NULL, NULL);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt) VALUES ('Cristian','cristy2001','cristian.pruna01@gmail.com', 'HelenaEsPreciosa', 'M', 'UPF', 'Audio', 'Spain',
    '2001-7-30', 'S', NULL, NULL);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt) VALUES ('Lucas','lucas','lucas.pruna01@gmail.com', 'lucasEsUnPelotudo', 'M', 'UPF', 'Computer', 
    'Argentina', '1999-3-1', 'S', NULL, NULL);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt) VALUES ('Moni','moni','moni.pruna01@gmail.com', 'moni2001', 'F', 'UPF', 'Computer', 'Spain','2001-1-1',
    'S', NULL, NULL);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt) VALUES ('Helena','Helena','helena.pruna01@gmail.com', 'BadBunnyBB', 'F', 'UPF', 'Computer', 'Spain',
    '2001-1-30', 'S', NULL, NULL);

INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 4);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 4);
INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(1, 2);
INSERT INTO `follows`(follower_id, followed_id) VALUES(3, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(2, 1);
INSERT INTO `follows`(follower_id, followed_id) VALUES(4, 1);


INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 1, 'hello im Anna');
INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 3, 'hello im Cristian and Helena is my best friend');
INSERT INTO tweet(parent_id, user_id, content) VALUES(2, 6, 'ohhh, thx');
INSERT INTO tweet(parent_id, user_id, content) VALUES(NULL, 4, 'Computer science is superior');




