USE lab3; 
SELECT * FROM `user`;
SELECT * FROM junction;
SELECT * FROM tweet;

#currently the user that follows more people is cristian so let's search 
#	for the tweets these people have posted

SELECT content FROM tweet WHERE user_id = ANY (SELECT followed_id FROM junction WHERE follower_id = 3);