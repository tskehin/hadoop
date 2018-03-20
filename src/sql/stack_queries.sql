--46735
select *
from posts 
where posts.ViewCount BETWEEN 24000 AND 30000;

--46160
select * 
from posts 
where posts.ViewCount BETWEEN 30000 AND 40000;

--44573
select * 
from posts 
where posts.ViewCount BETWEEN 40000 AND 60000;

--47642
select * 
from posts 
where posts.ViewCount BETWEEN 60000 AND 150000;

--17064
select *
from posts 
where posts.ViewCount > 150000;


--RECONCILIATION
--number of users on stack exhange with hadoop in the title or body
SELECT COUNT(DISTINCT OwnerUserId)
FROM posts 
WHERE posts.ViewCount > 24000
AND(Title LIKE '%hadoop%'OR Body LIKE '%hadoop%');

--number of records in source tables with NULL OwnerUserId
SELECT COUNT(*)
FROM posts 
WHERE posts.ViewCount > 24000
AND OwnerUserId IS NULL