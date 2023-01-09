-- 1. Proportion of international players vs. US players since 2000-01 season

SELECT 
    (CASE
        WHEN country != 'USA' THEN 'International'
        ELSE 'USA'
    END) AS region,
    COUNT(DISTINCT (player_name)) AS player_count,
    season
FROM
    projects.all_seasons
WHERE
    season LIKE '2%'
GROUP BY region, season
ORDER BY season DESC , player_count DESC;


-- 2. Number of international players grouped by season

SELECT
  COUNT(DISTINCT(player_name)) AS int_player_count,
  season
FROM projects.all_seasons
WHERE 
  country != 'USA'
  AND season LIKE '2%'
GROUP BY season
ORDER BY season; 

-- 3. Number of international players grouped by country since 2000-01

SELECT 
  COUNT(DISTINCT(player_name)) AS player_count,
  country
FROM projects.all_seasons
WHERE 
  season LIKE '2%'
  AND country != 'USA'
GROUP BY country
ORDER BY player_count DESC;

-- 4. International all stars since 2000-01 grouped by country

SELECT 
  COUNT(DISTINCT(name)) AS player_count,
  country
FROM projects.all_seasons
JOIN projects.allstar
  ON projects.all_seasons.player_name = projects.allstar.name
WHERE 
  season LIKE '2%'
  AND country != 'USA'
GROUP BY country
ORDER BY player_count DESC;

-- 5. Top ten players in ppg per season since 2000-01 

WITH a 
AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2000-01'
ORDER BY pts DESC
LIMIT 10),

b AS
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2001-02'
ORDER BY pts DESC
LIMIT 10),

c AS
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2002-03'
ORDER BY pts DESC
LIMIT 10),

d AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2003-04'
ORDER BY pts DESC
LIMIT 10),

e AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2004-05'
ORDER BY pts DESC
LIMIT 10),

f AS
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2005-06'
ORDER BY pts DESC
LIMIT 10),

g AS
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2006-07'
ORDER BY pts DESC
LIMIT 10),

h AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2007-08'
ORDER BY pts DESC
LIMIT 10),

i AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2008-09'
ORDER BY pts DESC
LIMIT 10),

j AS
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2009-10'
ORDER BY pts DESC
LIMIT 10),

k AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2010-11'
ORDER BY pts DESC
LIMIT 10),

l AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2011-12'
ORDER BY pts DESC
LIMIT 10),

m AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2012-13'
ORDER BY pts DESC
LIMIT 10),

n AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2013-14'
ORDER BY pts DESC
LIMIT 10),

o AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2014-15'
ORDER BY pts DESC
LIMIT 10),

p AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2015-16'
ORDER BY pts DESC
LIMIT 10),

q AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2016-17'
ORDER BY pts DESC
LIMIT 10),

r AS 
(select 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2017-18'
ORDER BY pts DESC
LIMIT 10),

s AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2018-19'
ORDER BY pts DESC
LIMIT 10),

t AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2019-20'
ORDER BY pts DESC
LIMIT 10),

u AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2020-21'
ORDER BY pts DESC
LIMIT 10),

v AS 
(SELECT 
  player_name,
  pts,
  country,
  season
FROM projects.all_seasons
WHERE season = '2021-22'
ORDER BY pts DESC
LIMIT 10)

SELECT *
FROM a 
UNION ALL 
SELECT * FROM b
UNION ALL 
SELECT * FROM c
UNION ALL 
SELECT * FROM d
UNION ALL 
SELECT * FROM e
UNION ALL 
SELECT * FROM f
UNION ALL 
SELECT * FROM g
UNION ALL 
SELECT * FROM h
UNION ALL 
SELECT * FROM i
UNION ALL 
SELECT * FROM j
UNION ALL 
SELECT * FROM k
UNION ALL 
SELECT * FROM l
UNION ALL 
SELECT * FROM m
UNION ALL 
SELECT * FROM n
UNION ALL 
SELECT * FROM o
UNION ALL 
SELECT * FROM p
UNION ALL 
SELECT * FROM q
UNION ALL 
SELECT * FROM r
UNION ALL 
SELECT * FROM s
UNION ALL 
SELECT * FROM t
UNION ALL 
SELECT * FROM u
UNION ALL 
SELECT * FROM v
ORDER BY 
  season DESC, 
  pts DESC;
