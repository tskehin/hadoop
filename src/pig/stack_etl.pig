--Register the piggybank jar
REGISTER /usr/local/pig/contrib/piggybank/java/piggybank.jar

records = LOAD '/pig/*.csv' 
USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'YES_MULTILINE', 'UNIX', 'SKIP_INPUT_HEADER')
AS 
(
 Id:int
,PostTypeId:int
,AcceptedAnswerId:int
,ParentId:int
,CreationDate:chararray
,DeletionDate:chararray
,Score:int
,ViewCount:int
,Body:chararray
,OwnerUserId:int
,OwnerDisplayName:chararray
,LastEditorUserId:int
,LastEditorDisplayName:chararray
,LastEditDate:chararray
,LastActivityDate:chararray
,Title:chararray
,Tags:chararray
,AnswerCount:int
,CommentCount:int
,FavoriteCount:int
,ClosedDate:chararray
,CommunityOwnedDate:chararray
);

distinct_records = DISTINCT records;

final = FOREACH distinct_records GENERATE OwnerUserId, Id, Score, Title, REPLACE(REPLACE(Body, '<.*?.>', ''), '\n', ' ') AS Body;
test = FILTER final BY OwnerUserId == 3106062;

rmf /pig/output;
STORE final INTO '/pig/output/posts' USING PigStorage('\u0001');
STORE test INTO '/pig/output/json' USING JsonStorage();