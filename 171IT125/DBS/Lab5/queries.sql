-- 1.Create a view called TNS containing title-name-stars triples, 
-- where the movie (title) was reviewed by a reviewer (name) 
-- and received the rating (stars). Then referencing only view TNS 
-- and table Movie, write a SQL query that returns the lastest year 
-- of any movie reviewed by Chris Jackson. You may assume movie names are unique.
create view TNS as select title,name,stars 
	from Movie M inner join Rating R on M.mID=R.mID inner join Reviewer Re on Re.rID=R.rID;

select max(year) from Movie M inner join TNS T on M.title=T.title and name="Chris Jackson";

-- 2.Referencing view TNS from Exercise 1 and no other tables, create a view RatingStats 
-- containing each movie title that has at least one rating, the number of ratings it received, 
-- and its average rating. Then referencing view RatingStats and no other tables, 
-- write a SQL query to find the title of the highest-average-rating movie with at least three ratings.
create view RatingStats as select title,count(stars) as Count_Stars,avg(stars) as Avg_Stars from TNS 
	group by title having count(stars)>=1;

select title from RatingStats where Avg_Stars in (select max(Avg_Stars) 
	from RatingStats where title in (select title from RatingStats where Count_Stars>=3));


-- 3.Create a view Favorites containing rID-mID pairs, where the reviewer with rID gave the movie with 
-- mID the highest rating he or she gave any movie. Then referencing only view Favorites and tables Movie 
-- and Reviewer, write a SQL query to return reviewer-reviewer-movie triples 
-- where the two (different) reviewers have the movie as their favorite. Return each pair once, i.e., 
-- don't return a pair and its inverse.

create view Favourites as select rID,mID from Rating where (rID,stars) in (select rID,max(stars) 
	as Max_Stars from Rating group by rID);

select C.name,D.name,title from Favourites A inner join Favourites B 
	on A.mID = B.mID and A.rID != B.rID inner join Reviewer C on A.rID=C.rID 
	inner join Reviewer D on B.rID=D.rID inner join Movie M on M.mID=A.mID and B.rID<A.rID;

