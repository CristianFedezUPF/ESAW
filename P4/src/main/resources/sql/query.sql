USE unitter; 

SELECT * FROM `user`;
SELECT * FROM `follows`;
SELECT * FROM tweet;
SELECT * FROM `like`;


#currently the user that follows more people is cristian (with id = 3) so let's search 
#	for the tweets these people have posted

SELECT content FROM tweet WHERE user_id IN (SELECT followed_id FROM `follows` WHERE follower_id = 3);

SELECT * FROM tweet ORDER BY creation_timestamp DESC;
SELECT TIMEDIFF(NOW(), UTC_TIMESTAMP);

SELECT tweet.id, tweet.user_id,tweet.creation_timestamp,tweet.content,user.username,user.name
FROM tweet 
JOIN user ON user.id = tweet.user_id
JOIN follows ON follows.follower_id = user.id
WHERE user.id = 1;

SELECT tweet.id, tweet.user_id, tweet.creation_timestamp, tweet.content, user.username, user.name
FROM tweet JOIN user ON tweet.user_id = user.id
WHERE tweet.user_id IN 
(SELECT followed_id FROM follows WHERE follower_id = 1 OR follower_id = 2)
ORDER BY tweet.creation_timestamp DESC;

SELECT user.id, user.username, user.name, user.university, user.degree;



SELECT user.id, user.username, user.name, user.university, user.degree
FROM user WHERE user.id IN (
SELECT followed_id FROM follows WHERE follower_id = ?)
ORDER BY rand()
LIMIT ?;

UPDATE tweet
SET 
content = "hola",
edit_timestamp = NOW()
WHERE id = 1;

