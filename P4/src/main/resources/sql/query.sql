USE unitter; 

SELECT * FROM `user`;
SELECT * FROM `follows`;
SELECT * FROM tweet;

#currently the user that follows more people is cristian (with id = 3) so let's search 
#	for the tweets these people have posted

SELECT content FROM tweet WHERE user_id IN (SELECT followed_id FROM `follows` WHERE follower_id = 3);

SELECT * FROM user WHERE username LIKE "Anna";