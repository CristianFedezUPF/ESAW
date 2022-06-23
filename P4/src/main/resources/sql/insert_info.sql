USE unitter; 

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
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-03 15:03:53", 2, 'Hello im Cristian and Helena is my best friend');
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-03 15:23:53", 2, 'nah it\'s totally false lmao');
INSERT INTO tweet(creation_timestamp, user_id, content) VALUES("2022-06-03 15:26:07", 2, 'jkjk ly Helena');
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
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('8', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('19', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('16', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('21', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('22', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('18', '1');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('21', '2');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('15', '2');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('22', '2');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('2', '3');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('17', '3');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('14', '3');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('19', '3');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('18', '4');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('14', '4');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('19', '4');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('16', '5');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('15', '5');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('1', '5');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('1', '6');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('1', '7');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('16', '7');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('1', '7');
INSERT INTO `like` (`tweet_id`, `user_id`) VALUES ('19', '16');


INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-04 15:22:53", '6', '1');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-04 15:23:00", '8', '1');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-10 15:15:03", '20', '1');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-10 00:49:53", '9', '8');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-17 16:13:53", '10', '8');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-19 21:13:53", '11', '8');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-21 00:49:53", '17', '3');
INSERT INTO retweet (creation_timestamp, tweet_id, user_id) VALUES ("2022-06-23 23:24:33", '15', '2');




