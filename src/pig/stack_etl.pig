--Register the piggybank jar
REGISTER /usr/local/pig/contrib/piggybank/java/piggybank.jar
define CSVExcelStorage org.apache.pig.piggybank.storage.CSVExcelStorage();  

A = LOAD '/pig/query_test.csv' using CSVExcelStorage(',', 'YES_MULTILINE', 'WINDOWS', 'SKIP_INPUT_HEADER')
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

B = FILTER A BY (ViewCount == 2220431);

DUMP B;