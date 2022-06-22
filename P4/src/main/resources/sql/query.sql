USE unitter; 

SELECT * FROM `user`;
SELECT * FROM `follows`;
SELECT * FROM tweet;
SELECT * FROM `like`;
SELECT * FROM retweet;

DELETE FROM retweet WHERE tweet_id = 5 AND user_id = 4;
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

SELECT tweet.id, tweet.user_id, tweet.content, tweet.creation_timestamp AS tweet_creation_timestamp, tweet.edit_timestamp,
tweet.like_count, tweet.retweet_count, 
user.username, user.name,
retweet.user_id AS retweet_user_id, 
(SELECT name FROM user WHERE id = retweet.user_id) AS retweet_user_name,
retweet.creation_timestamp AS retweet_timestamp
FROM tweet LEFT JOIN retweet ON retweet.tweet_id = id
INNER JOIN user ON user.id = tweet.user_id
UNION 
SELECT tweet.id, tweet.user_id, tweet.content,  tweet.creation_timestamp AS tweet_creation_timestamp, tweet.edit_timestamp,
tweet.like_count, tweet.retweet_count, 
user.username, user.name,
NULL AS retweet_user_id, NULL AS retweet_user_name, NULL as retweet_timestamp
FROM tweet
INNER JOIN user ON user.id = tweet.user_id
ORDER BY
    CASE 
		WHEN retweet_timestamp IS NULL THEN tweet_creation_timestamp
        WHEN retweet_timestamp > tweet_creation_timestamp THEN retweet_timestamp
        WHEN tweet_creation_timestamp > retweet_timestamp THEN tweet_creation_timestamp
    END DESC;

SELECT * FROM (
SELECT tweet.id, tweet.user_id, tweet.content, tweet.creation_timestamp AS tweet_creation_timestamp, tweet.edit_timestamp,
tweet.like_count, tweet.retweet_count, 
user.username, user.name,
retweet.user_id AS retweet_user_id, 
(SELECT name FROM user WHERE id = retweet.user_id) AS retweet_user_name,
retweet.creation_timestamp AS retweet_timestamp
FROM tweet LEFT JOIN retweet ON retweet.tweet_id = id
INNER JOIN user ON user.id = tweet.user_id
UNION 
SELECT tweet.id, tweet.user_id, tweet.content,  tweet.creation_timestamp AS tweet_creation_timestamp, tweet.edit_timestamp,
tweet.like_count, tweet.retweet_count, 
user.username, user.name,
NULL AS retweet_user_id, NULL AS retweet_user_name, NULL as retweet_timestamp
FROM tweet
INNER JOIN user ON user.id = tweet.user_id
ORDER BY
    CASE 
		WHEN retweet_timestamp IS NULL THEN tweet_creation_timestamp
        WHEN retweet_timestamp > tweet_creation_timestamp THEN retweet_timestamp
        WHEN tweet_creation_timestamp > retweet_timestamp THEN tweet_creation_timestamp
    END DESC
) AS T1 WHERE (user_id = 1 AND (retweet_user_id = 1 OR retweet_user_id IS NULL)) OR retweet_user_id = 1;

"SELECT tweet.id, tweet.user_id, tweet.creation_timestamp, tweet.edit_timestamp, "
				+ "tweet.content, tweet.like_count,  tweet.retweet_count,"
				+ "user.username, user.name\r\n"
				+ "FROM tweet JOIN user ON tweet.user_id = user.id\r\n"
				+ "WHERE tweet.user_id IN \r\n"
				+ "(SELECT followed_id FROM follows WHERE follower_id = ?)\r\n"
				+ "OR tweet.user_id = ?\r\n"
				+ "ORDER BY tweet.creation_timestamp DESC LIMIT ?,?";

SELECT * FROM (
SELECT tweet.id, tweet.user_id, tweet.content, tweet.creation_timestamp AS tweet_creation_timestamp, tweet.edit_timestamp,
tweet.like_count, tweet.retweet_count, 
user.username, user.name,
retweet.user_id AS retweet_user_id, 
(SELECT name FROM user WHERE id = retweet.user_id) AS retweet_user_name,
retweet.creation_timestamp AS retweet_timestamp
FROM tweet LEFT JOIN retweet ON retweet.tweet_id = id
INNER JOIN user ON user.id = tweet.user_id
UNION 
SELECT tweet.id, tweet.user_id, tweet.content,  tweet.creation_timestamp AS tweet_creation_timestamp, tweet.edit_timestamp,
tweet.like_count, tweet.retweet_count, 
user.username, user.name,
NULL AS retweet_user_id, NULL AS retweet_user_name, NULL as retweet_timestamp
FROM tweet
INNER JOIN user ON user.id = tweet.user_id
ORDER BY
    CASE 
		WHEN retweet_timestamp IS NULL THEN tweet_creation_timestamp
        WHEN retweet_timestamp > tweet_creation_timestamp THEN retweet_timestamp
        WHEN tweet_creation_timestamp > retweet_timestamp THEN tweet_creation_timestamp
    END DESC
) AS T1 WHERE T1.user_id IN (SELECT followed_id FROM follows WHERE follower_id = 1) OR (IF(T1.retweet_user_id IS NULL, T1.user_id = 1, NULL))
OR T1.retweet_user_id IN (SELECT followed_id FROM follows WHERE follower_id = 1) OR T1.retweet_user_id = 1;

UPDATE tweet
SET 
content = "hola",
edit_timestamp = NOW()
WHERE id = 1;
