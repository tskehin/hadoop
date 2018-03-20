--create external table pointing at pig output
DROP TABLE Posts;
CREATE EXTERNAL TABLE Posts
(
 OwnerUserId INT	
,Id INT
,Score BIGINT
,Title STRING
,Body STRING
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\u0001' 
LOCATION '/pig/output/posts/';
