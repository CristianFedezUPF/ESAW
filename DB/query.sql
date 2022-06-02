USE lab3; 
SELECT * FROM `user`;
SELECT * FROM `following`;
SELECT * FROM tweet;

#currently the user that follows more people is cristian (with id = 3) so let's search 
#	for the tweets these people have posted

SELECT content FROM tweet WHERE user_id = ANY (SELECT followed_id FROM `following` WHERE follower_id = 3);