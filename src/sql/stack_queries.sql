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