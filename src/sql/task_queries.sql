--total records

INSERT OVERWRITE DIRECTORY '/results/answerset_1'
SELECT COUNT(*)
FROM Posts;

--top posts by score
INSERT OVERWRITE DIRECTORY '/results/answerset_2'
SELECT Score, Title 
FROM Posts 
ORDER BY Score 
DESC LIMIT 10;

--top users by score
INSERT OVERWRITE DIRECTORY '/results/answerset_3'
SELECT OwnerUserId, Score, Title
FROM Posts 
ORDER BY Score DESC LIMIT 10;

--user by total score, excluding NULL records
INSERT OVERWRITE DIRECTORY '/results/answerset_4'
SELECT OwnerUserId, SUM(Score) AS TotalScore 
FROM Posts 
WHERE OwnerUserId IS NOT NULL
GROUP BY OwnerUserId
ORDER BY TotalScore DESC LIMIT 10;

