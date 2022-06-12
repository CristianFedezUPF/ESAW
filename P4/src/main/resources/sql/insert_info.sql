USE unitter; 

ALTER TABLE `user` AUTO_INCREMENT = 1;
ALTER TABLE tweet AUTO_INCREMENT = 1;


#pwd: ssssss
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, admin) VALUES ('Anna Pruna Craus','AnnaPruna','anna.pruna@gmail.com', 'Y4à=Ó3*ÉRcñqy6j`Ácæ³­ÔÞ=', 'NB', 'Universitat Pompeu Fabra', NULL, 'Spain','1997-1-1', 
    'T', NULL, "ÝZ)lmVÁtã´Ú", false);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, admin) VALUES ('Helena Pruna Craus','HelenaPruna','helena.pruna@gmail.com', '¼³PÌáI±³NÎ¼EÀÑÚÐæ8^Jp¬¶á', 'F', 'UPF', 'Computer Science', 'Spain','2001-03-23',
    'S', NULL, '(hS5rmçg àòÉ', true); 
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, admin) VALUES ('Cristian Fernández Moreno','CristianFedez','cristianfedez@gmail.com', 'Ü|xªGTûßÕ_¼-Ì®-Vg¢wSPÇgöÔFÊ8', 'M', 'Universitat Pompeu Fabra', 'Enginyeria de Sistemes Audiovisuals', 'Spain',
    '2001-07-30', 'S', NULL, 'uXpÐÚïÓI½SÄR0f%', true);
INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, admin) VALUES ('Lucas Damián Chindemi Santa Cruz','PatoLucas','lucas.chindemi@gmail.com', 'nR²¶êLðùR
Êø³üÏ¹¯¥ûlHÁS®', 'M', 'UPF', 'Computer', 
    'Argentina', '1999-3-1', 'S', NULL, '9û>íue ©.²;[=', true);
    INSERT INTO `user`(`name`, username, email,`password`, gender, university, degree, country, birthday, `position`, 
	image_path, salt, admin) VALUES ('Moni','moni','moni01@gmail.com', 'xUh·Z7âU³¢2yù$öäg¶åáhéþì', 'F', 'Universitat Pompeu Fabra', 'Computer Science', 'Spain',
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


SELECT tweet.id,tweet.user_id,tweet.date,tweet.content,user.username,user.name FROM tweet INNER JOIN user ON user.id = tweet.user_id;

