-- join 
SELECT matchid, player FROM goal
WHERE teamid = 'GER'

SELECT id,stadium,team1,team2
  FROM game
  WHERE id = 1012
  
  
SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
  WHERE teamid = 'GER'
  
SELECT team1, team2, player FROM game
  JOIN goal ON (id=matchid)
  WHERE player LIKE 'Mario%'
  
SELECT player, teamid, coach, gtime
  FROM goal
  JOIN eteam on (teamid=id)
 WHERE gtime<=10
 
SELECT mdate,teamname FROM game
  JOIN eteam ON (team1 = eteam.id)
  WHERE coach = 'Fernando Santos'
  
SELECT player FROM goal
  JOIN game ON (matchid = id)
  WHERE stadium = 'National Stadium, Warsaw'
  
More Difficult Questions....
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id
    WHERE (team1= 'GER' OR team2='GER')
    AND teamid != 'GER'
	
SELECT teamname, COUNT(*)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname
 
SELECT stadium, COUNT(*) FROM goal
  JOIN game ON (matchid = id)
  GROUP BY stadium
  
SELECT matchid, mdate, COUNT(*)
  FROM game JOIN goal ON matchid = id
  WHERE (team1 = 'POL' OR team2 = 'POL')
  GROUP BY mdate,matchid
  
SELECT matchid, mdate, COUNT(*) FROM goal
  JOIN game ON (matchid=id)
  WHERE teamid = 'GER'
  GROUP BY matchid, mdate
  
SELECT DISTINCT mdate, team1,
	SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
    team2,
    SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game
LEFT JOIN goal ON game.id = goal.matchid
GROUP BY id, mdate, team1, team2
ORDER BY mdate, matchid, team1, team2


More JOIN
SELECT id, title
 FROM movie
 WHERE yr=1962
 
SELECT yr
  FROM movie
  WHERE title = 'Citizen Kane'
  
SELECT id, title, yr FROM movie
  WHERE title LIKE '%Star Trek%'
  ORDER BY yr
  
SELECT title FROM movie
  WHERE id IN (11768, 11955, 21191)
SELECT id FROM actor
  WHERE name = 'Glenn Close'
  
SELECT id FROM movie
  WHERE title = 'Casablanca'
SELECT name FROM casting JOIN actor ON (id=actorid)
  WHERE movieid=11768
  
SELECT name FROM casting
  JOIN actor ON (actor.id=actorid)
  JOIN movie ON (movie.id=movieid)
  WHERE title = 'Alien'
  
SELECT title FROM casting
  JOIN movie ON (movie.id = movieid)
  JOIN actor ON (actor.id = actorid)
  WHERE name = 'Harrison Ford'
  
SELECT title FROM casting
  JOIN movie ON (movie.id = movieid)
  JOIN actor ON (actor.id = actorid)
  WHERE name = 'Harrison Ford'  AND ord > 1
  
SELECT title, name FROM casting
  JOIN movie ON (movie.id = movieid)
  JOIN actor ON (actor.id = actorid)
  WHERE yr = 1962 and ord = 1
  
Harder Questions
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 WHERE name='John Travolta'
 GROUP BY yr) AS t
)
SELECT title, name FROM casting
  JOIN movie ON movie.id = movieid
  JOIN actor ON actor.id = actorid
WHERE ord = 1
	AND movie.id IN
	(SELECT movie.id FROM movie
	   JOIN casting ON movie.id = movieid
	   JOIN actor ON actor.id = actorid
           WHERE actor.name = 'Julie Andrews')
		   
SELECT DISTINCT name FROM casting
  JOIN movie ON movie.id = movieid
  JOIN actor ON actor.id = actorid
  WHERE actorid IN (
	SELECT actorid FROM casting
	  WHERE ord = 1
	  GROUP BY actorid
	  HAVING COUNT(actorid) >= 30)
ORDER BY name

SELECT title, COUNT(actorid) FROM casting
  JOIN movie ON movieid = movie.id
  WHERE yr = 1978
  GROUP BY movieid, title
  ORDER BY COUNT(actorid) DESC
  
SELECT DISTINCT name FROM casting
  JOIN actor ON actorid = actor.id
  WHERE name != 'Art Garfunkel'
	AND movieid IN (
		SELECT movieid
		FROM movie
		JOIN casting ON movieid = movie.id
		JOIN actor ON actorid = actor.id
		WHERE actor.name = 'Art Garfunkel'
)
  
  


-- Self JOIN
SELECT DISTINCT COUNT(*) FROM stops

SELECT id FROM stops
  WHERE name = 'Craiglockhart'
  
SELECT id, name FROM stops JOIN route ON (stops.id = route.stop)
  WHERE num = 4
  
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = (SELECT id FROM stops WHERE name = 'London Road')

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' and stopb.name = 'London Road'

SELECT a.company, a.num  
FROM route a, route b
WHERE a.num = b.num AND (a.stop = 115 AND b.stop = 137)
GROUP BY num;

SELECT a.company, a.num
FROM route a
JOIN route b ON (a.company = b.company AND a.num = b.num)
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart'
AND stopb.name = 'Tollcross';

SELECT DISTINCT name, a.company, a.num
FROM route a
JOIN route b ON (a.company = b.company AND a.num = b.num)
JOIN stops ON a.stop = stops.id
WHERE b.stop = 53;

SELECT a.num, a.company, stopb.name, c.num, c.company
FROM route a
JOIN route b ON (a.company = b.company AND a.num = b.num)
JOIN (route c JOIN route d ON (c.company = d.company AND c.num = d.num))
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
JOIN stops stopc ON c.stop = stopc.id
JOIN stops stopd ON d.stop = stopd.id
WHERE stopa.name = 'Craiglockhart'
	AND stopd.name = 'Sighthill'
	AND stopb.name = stopc.name
ORDER BY LENGTH(a.num), b.num, stopb.name, LENGTH(c.num), d.num;



















----musicians
11.

select a.m_name, c.place_town
from
(select * from musician) a
join
(select born_in from musician where m_name = 'James First') b
join
(select * from place) c

on a.born_in = b.born_in and a.born_in = c.place_no

12.

select a.m_name as musician, count(e.cmpn_no) as compositions, count(c.instrument) as instruments
from
(select * from musician) a
join
(select * from place where place_country = 'England') b
join
(select * from performer) c
join
(select * from composer) d
join
(select * from has_composed) e

on a.born_in = b.place_no and a.m_no = c.perf_is and a.m_no= d.comp_is and d.comp_no = e.cmpn_no

group by a.m_name

13.
select b.band_name as band, a.m_name as conductor, b.band_contact as contact
from
(select * from musician) a
join
(select * from band) b 
join
(select * from concert where concert_venue = 'Royal Albert Hall') c
join
(select * from performance) d
on a.m_no = d.conducted_by and d.performed_in = c.concert_no and d.gave = b.band_no

14.


select a.* from
(select m_name as name, 

case when m_no in (select m_no from musician
join place on musician.born_in = place.place_no and place.place_town ='Glasgow')
then 'Yes' else null end as Born_In,

case when m_no in (select m_no from musician
join place on musician.living_in = place.place_no and place.place_town ='Glasgow')
then 'Yes' else null end as Lives_In,

case when m_no in (select a.m_no from
(select m_no from musician) a
join
(select * from plays_in) b 
join
(select * from performance) c
join
(select * from place where place.place_town ='Glasgow' ) d
join
(select * from concert) e
on a.m_no = b.player 
and b.band_id = c.gave 
and c.performed_in = e.concert_no 
and d.place_no = e.concert_in) then 'Yes' else null end as Performed_In,

case when m_no in
(select a.m_no
from
(select m_no from musician) a
join
(select * from plays_in) b
join
(select * from band) c
join
(select * from place where place.place_town ='Glasgow' ) d
on a.m_no = b.player and b.band_id = c.band_no and c.band_home = d.place_no)
then 'Yes' else null end as In_Band_In

from musician ) a
where (a.born_in is not null or a.lives_in is not null or a.performed_in is not null or a.in_band_in is not null)

15.


select a.player, a.band_id, b.band_id

from

(select * from plays_in
where band_id in
(select b.band_id from musician a
join plays_in b
on a.m_no = b.player where a.m_name = 'James First')) a

join

(select * from plays_in
where band_id in
(select b.band_id from musician a
join plays_in b
on a.m_no = b.player where a.m_name = 'Davis Heavan')) b

on a.player = b.player



-- congestion
/* - Congestion Easy */
/* -- Question 1 */
select keeper.name, keeper.address from keeper inner join vehicle on keeper.id=vehicle.keeper where vehicle.id='SO 02 PSP' group by keeper.name, keeper.address;

/* -- Question 2 */
select count(*) from camera;

/* -- Question 3 */
select image.camera, image.whn, image.reg from image where image.camera=10  and image.whn < '2007-02-26';

/* -- Question 4 */
select image.camera, count(*) from image
  where camera not in (15, 16, 17, 18, 19)
  group by camera;

/* -- Question 5 */
 -- Names and addresses 
select keeper.name, keeper.address from keeper inner join (
select * from permit inner join vehicle
  on vehicle.id=permit.reg
  where sDate= '2007-01-30') as temp1 on temp1.keeper=keeper.id
  group by keeper.name, keeper.address
  order by keeper.name asc;

-- Vehicles with keeper ID with registrations starting on 1/30/2007 
select * from permit inner join vehicle
  on vehicle.id=permit.reg
  where sDate= '2007-01-30';

-- Vehicles with registrations starting on 1/30/2007
select * from permit where sDate = '2007-01-30';

 -- Congestion Medium 
 -- Question 1 
select name, address from image inner join (select vehicle.id as reg, keeper.name, keeper.address from keeper inner join vehicle on keeper.id=vehicle.keeper group by vehicle.id, keeper.name, keeper.address) as reg_owner on image.reg=reg_owner.reg where image.camera in (1, 18) group by name, address;

 -- Reg to owner
select vehicle.id as reg, keeper.name, keeper.address from keeper inner join vehicle on keeper.id=vehicle.keeper group by vehicle.id, keeper.name, keeper.address;

 -- Reg caught by 1 or 18 
select image.reg from image where image.camera in (1, 18) group by reg;

 -- Question 2
 -- Count of vehicles by owner 
select keeper, count (*) as count from vehicle group by keeper;

 -- Names and addresses of owners with over 5 vehicles 
select name, address from keeper inner join (select keeper, count (*) as count from vehicle group by keeper) as vehicle_count on keeper.id=vehicle_count.keeper where vehicle_count.count >5;

--Question 
select reg, sum(
	case
		when chargeType = 'Daily' then sDate + interval 1 day > '2007-02-01' and sDate <= '2007-02-01'
		when chargeType = 'Weekly' then sDate + interval 1 week > '2007-02-01' and sDate <= '2007-02-01'
		when chargeType = 'Monthly' then sDate + interval 1 month > '2007-02-01' and sDate <= '2007-02-01'
		when chargeType = 'Annual' then sDate + interval 1 year > '2007-02-01' and sDate <= '2007-02-01'
	end) as current from permit group by reg;
-- Question 
select whn, reg, name from image left outer join (
	select vehicle.id, name from keeper inner join vehicle on keeper.id = vehicle.keeper
	) as names on image.reg = names.id
	where camera = '10' and whn < '2007-02-26' and whn >= '2007-02-25';

-- Question 
select name, vehicle_count from (
	select name, keeper.id from (
		select keeper, sum(permit_count) as permit_count from (
			select reg, count(*) as permit_count from permit group by reg
		) as count_by_vehicle left outer join vehicle on count_by_vehicle.reg=vehicle.id group by keeper
	) as permit_counts left outer join keeper on keeper.id=keeper
	where permit_count > 2
) as names left outer join (
	select keeper, count(*) as vehicle_count from vehicle group by keeper
) as counts on names.id=counts.keeper where vehicle_count > 4;