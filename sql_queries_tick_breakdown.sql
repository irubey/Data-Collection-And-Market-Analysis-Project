select *
from user_ticklist_data;

-- Recreating mountain project tables/ data in tick breakdown section

-- Pitches, Routes, Days out:

SELECT 
  CASE 
    WHEN "Date" >= now() - INTERVAL '90 Days' THEN 'Past 90 Days'
    WHEN "Date" >= now() - INTERVAL '1 Year' THEN 'Past Year'
    WHEN "Date" >= now() - INTERVAL '5 Years' THEN 'Past 5 Years'
    ELSE 'All Time'
  END AS date_range,
  SUM("Pitches") AS "Total Pitches",
  COUNT(DISTINCT("Route")) AS "Unique Routes",
  COUNT(DISTINCT("Date")) AS "Days Out"
FROM user_ticklist_data
GROUP BY date_range;


-- Pitches by year of different styles

SELECT 
  CASE
    WHEN "Rating" LIKE '%Snow%' OR "Rating" LIKE '%W%' THEN 'Snow/Winter'
	WHEN "Rating" LIKE '%M%' THEN 'Mixed'
	WHEN "Rating" LIKE '%I%' THEN 'Ice'
	WHEN "Rating" LIKE '%C%' OR "Rating" LIKE '%A%' THEN 'Aid'
	WHEN "Rating" LIKE '%5.%' THEN 'Rock'
	WHEN "Rating" LIKE '%V%' OR "Route Type" LIKE '%Boulder%' THEN 'Boulder'
	WHEN "Route Type" LIKE '%Trad%' THEN 'Gear'
	WHEN "Route Type" LIKE '%Sport%' THEN 'Sport'
	WHEN "Route Type" LIKE '%TR%' THEN 'Top Rope'
	WHEN "Route Type" LIKE '%Alpine%' THEN 'Alpine'
	ELSE 'Unknown'
  END AS route_type,
  TO_CHAR(DATE_TRUNC('year', "Date"), 'YYYY') AS year,
  SUM("Pitches") AS "Total Pitches"
FROM user_ticklist_data
GROUP BY year, route_type
ORDER BY year;


--Pitches by month of different styles

SELECT 
  CASE
    WHEN "Rating" LIKE '%Snow%' OR "Rating" LIKE '%W%' THEN 'Snow/Winter'
	WHEN "Rating" LIKE '%M%' THEN 'Mixed'
	WHEN "Rating" LIKE '%I%' THEN 'Ice'
	WHEN "Rating" LIKE '%C%' OR "Rating" LIKE '%A%' THEN 'Aid'
	WHEN "Rating" LIKE '%5.%' THEN 'Rock'
	WHEN "Rating" LIKE '%V%' OR "Route Type" LIKE '%Boulder%' THEN 'Boulder'
	WHEN "Route Type" LIKE '%Trad%' THEN 'Gear'
	WHEN "Route Type" LIKE '%Sport%' THEN 'Sport'
	WHEN "Route Type" LIKE '%TR%' THEN 'Top Rope'
	WHEN "Route Type" LIKE '%Alpine%' THEN 'Alpine'
	ELSE 'Unknown'
  END AS route_type,
  DATE_TRUNC('month', "Date") AS month,
  SUM("Pitches") AS "Total Pitches"
FROM user_ticklist_data
GROUP BY month, route_type
ORDER BY month;


--PITCH COUNT BY GRADE

SELECT 
  CASE
    WHEN "Route Type" LIKE '%Sport%' OR "Route Type" LIKE '%Trad%' OR "Route Type" LIKE '%TR%' THEN
	  CASE 
		WHEN "Rating" LIKE '3%' OR "Rating" LIKE '4%' THEN 'Scramble'
		WHEN "Rating" LIKE '%Easy 5th%' OR "Rating" LIKE '%5.0%' OR "Rating" LIKE '%5.1 %' OR "Rating" LIKE '%5.2%' OR "Rating" LIKE '%5.3%' OR "Rating" LIKE '%5.4%' OR "Rating" LIKE '%5.5%' THEN 'Low 5th Class'
		WHEN "Rating" LIKE '%5.6%' THEN '5.6'
		WHEN "Rating" LIKE '%5.7%' THEN '5.7'
		WHEN "Rating" LIKE '%5.8%' THEN '5.8'
		WHEN "Rating" LIKE '%5.9%' THEN '5.9'
		WHEN "Rating" LIKE '%5.10a%' OR "Rating" LIKE '%5.10-%' THEN '5.10-'
		WHEN "Rating" LIKE '%5.10b%' OR "Rating" LIKE '%5.10c%' OR "Rating" LIKE '5.10' OR "Rating" LIKE '%5.10 %' THEN '5.10'
		WHEN "Rating" LIKE '%5.10d%' OR "Rating" LIKE '%5.10+%' THEN '5.10+'
		WHEN "Rating" LIKE '%5.11a%' OR "Rating" LIKE '%5.11-%' THEN '5.11-'
		WHEN "Rating" LIKE '%5.11b%' OR "Rating" LIKE '%5.11c%' OR "Rating" LIKE '5.11' OR "Rating" LIKE '%5.11 %' THEN '5.11'
		WHEN "Rating" LIKE '%5.11d%' OR "Rating" LIKE '%5.11+%' THEN '5.11+'
		WHEN "Rating" LIKE '%5.12a%' OR "Rating" LIKE '%5.12-%' THEN '5.12-'
		WHEN "Rating" LIKE '%5.12b%' OR "Rating" LIKE '%5.12c%' OR "Rating" LIKE '5.12' OR "Rating" LIKE '%5.12 %'THEN '5.12'
		WHEN "Rating" LIKE '%5.12d%' OR "Rating" LIKE '%5.12+%' THEN '5.12+'
		WHEN "Rating" LIKE '%5.13a%' OR "Rating" LIKE '%5.13-%' THEN '5.13-'
		WHEN "Rating" LIKE '%5.13b%' OR "Rating" LIKE '%5.13c%' OR "Rating" LIKE '5.13' OR "Rating" LIKE '%5.13 %'THEN '5.13'
		WHEN "Rating" LIKE '%5.13d%' OR "Rating" LIKE '%5.13+%' THEN '5.13+'
		WHEN "Rating" LIKE '%5.14a%' OR "Rating" LIKE '%5.14-%' THEN '5.14-'
		WHEN "Rating" LIKE '%5.14b%' OR "Rating" LIKE '%5.14c%' OR "Rating" LIKE '5.14' OR "Rating" LIKE '%5.14 %'THEN '5.14'
		WHEN "Rating" LIKE '%5.14d%' OR "Rating" LIKE '%5.14+%' THEN '5.14+'
		WHEN "Rating" LIKE '%5.15a%' OR "Rating" LIKE '%5.15-%' THEN '5.15-'
		WHEN "Rating" LIKE '%5.15b%' OR "Rating" LIKE '%5.15c%' OR "Rating" LIKE '5.15' OR "Rating" LIKE '%5.15 %'THEN '5.15'
		WHEN "Rating" LIKE '%5.15d%' OR "Rating" LIKE '%5.15+%'THEN '5.15+'
		ELSE 'Unknown'
		  END
	WHEN "Route Type" LIKE '%Boulder%' THEN
	  CASE
	    WHEN "Rating" LIKE '%V-easy%' THEN 'V-Easy'
		WHEN "Rating" LIKE '%V0%' THEN 'V0'
		WHEN "Rating" LIKE '%V1%' THEN 'V1'
		WHEN "Rating" LIKE '%V2%' THEN 'V2'
		WHEN "Rating" LIKE '%V3%' THEN 'V3'
		WHEN "Rating" LIKE '%V4%' THEN 'V4'
		WHEN "Rating" LIKE '%V5%' THEN 'V5'
		WHEN "Rating" LIKE '%V6%' THEN 'V6'
		WHEN "Rating" LIKE '%V7%' THEN 'V7'
		WHEN "Rating" LIKE '%V8%' THEN 'V8'
		WHEN "Rating" LIKE '%V9%' THEN 'V9'
		WHEN "Rating" LIKE '%V10%' THEN 'V10'
		WHEN "Rating" LIKE '%11%' THEN 'V11'
		WHEN "Rating" LIKE '%V12%' THEN 'V12'
		WHEN "Rating" LIKE '%V13%' THEN 'V13'
		WHEN "Rating" LIKE '%V14%' THEN 'V14'
		WHEN "Rating" LIKE '%V15%' THEN 'V15'
		WHEN "Rating" LIKE '%V16%' THEN 'V16'
		WHEN "Rating" LIKE '%V17%' THEN 'V17'
		ELSE 'Unknown'
	  END
    ELSE 'Crazy Winter Peeps Probably'
  END AS grades,
COUNT("Pitches") AS total_pitches
FROM user_ticklist_data
Group By grades
ORDER BY total_pitches DESC;

-- EDA:
-- Users Stars vs the average over differnt time periods

SELECT 
  CASE 
    WHEN "Date" >= now() - INTERVAL '90 Days' THEN 'Past 90 Days'
    WHEN "Date" >= now() - INTERVAL '1 Year' THEN 'Past Year'
    WHEN "Date" >= now() - INTERVAL '5 Years' THEN 'Past 5 Years'
    ELSE 'All Time'
  END AS date_range,
  AVG(CASE WHEN "Your Stars" >= 0 THEN "Your Stars" ELSE NULL END) AS user_stars, 
  AVG(CASE WHEN "Avg Stars" >= 0 THEN "Avg Stars" ELSE NULL END) AS route_stars, 
  AVG(CASE WHEN "Your Stars" >= 0 THEN "Your Stars" - "Avg Stars" ELSE NULL END) AS difference,
  username
FROM user_ticklist_data
WHERE "Your Stars" >= 0 AND "Avg Stars" >= 0
GROUP BY username, date_range
ORDER BY username;

-- Average stars climbers have given a rating, vs the ratings of those climbs

SELECT 
AVG(CASE WHEN "Avg Stars" >= 0 THEN "Avg Stars" ELSE NULL END) AS avg_stars_all_rated_routes,
AVG(CASE WHEN "Your Stars" >= 0 THEN "Your Stars" ELSE NULL END) AS avg_user_stars,
AVG(CASE WHEN "Your Stars" < 0 THEN "Avg Stars" ELSE NULL END) AS avg_stars_when_no_user_rating
FROM user_ticklist_data;


-- Look at users max and average notes length

SELECT username, MAX(LENGTH("Notes")) AS max, AVG(LENGTH("Notes")) AS avg_len
FROM user_ticklist_data
group by username
ORDER BY avg_len desc, max;

--How does route length effect user grades?

SELECT 
  ROUND("Length" / 10) * 10 AS length_range,
  COUNT(*) AS num_entries,
  AVG(CASE WHEN "Your Stars" >= 0 THEN "Your Stars" ELSE NULL END) AS avg_user_stars,
  AVG("Pitches") AS avg_pitches
FROM user_ticklist_data
WHERE "Length" IS NOT NULL AND "Your Stars" IS NOT NULL
GROUP BY length_range
ORDER BY length_range;

-- Does lead style effect users grade?

SELECT 
DISTINCT("Lead Style"), 
COUNT("Lead Style"), 
AVG(CASE WHEN "Your Stars" >= 0 THEN "Your Stars" ELSE NULL END) AS avg_user_stars,
AVG(CASE WHEN "Avg Stars" >= 0 THEN "Avg Stars" ELSE NULL END) AS avg_stars,
AVG(CASE WHEN "Your Stars" >= 0 THEN "Your Stars" - "Avg Stars" ELSE NULL END) AS difference
FROM user_ticklist_data
GROUP BY "Lead Style"


--What year do users tick their first route

SELECT
  DATE_TRUNC('year', MIN("Date")) AS interval_start,
  COUNT(DISTINCT "username") AS num_users
FROM
  user_ticklist_data
GROUP BY
  DATE_TRUNC('year', "Date")
ORDER BY
  interval_start DESC;

-- What month do users tick their first route?

SELECT
  DATE_TRUNC('month', MIN("Date")) AS interval_start,
  COUNT(DISTINCT "username") AS num_users
FROM
  user_ticklist_data
GROUP BY
  DATE_TRUNC('month', "Date")
ORDER BY
  interval_start DESC;
  
  -- How many new users by date_accessed
  
SELECT COUNT(DISTINCT(username)), date_accessed
FROM user_ticklist_data
GROUP BY date_accessed
ORDER BY date_accessed;

-- How many unique users

SELECT COUNT(DISTINCT(username))
FROM user_ticklist_data

-- Most popular routes

SELECT "Route", "Rating", "Avg Stars", COUNT("Route") AS total_ticks
FROM user_ticklist_data
GROUP BY "Route", "Rating", "Avg Stars"
ORDER BY total_ticks DESC;

-- Popular locations

SELECT "Location", (COUNT("Location") AS ticks_per_location
FROM user_ticklist_data
GROUP BY "Location"
ORDER BY ticks_per_location DESC;

-- Popular locations by grade

SELECT 
CASE
    WHEN "Route Type" LIKE '%Sport%' OR "Route Type" LIKE '%Trad%' OR "Route Type" LIKE '%TR%' THEN
	  CASE 
		WHEN "Rating" LIKE '3%' OR "Rating" LIKE '4%' THEN 'Scramble'
		WHEN "Rating" LIKE '%Easy 5th%' OR "Rating" LIKE '%5.0%' OR "Rating" LIKE '%5.1 %' OR "Rating" LIKE '%5.2%' OR "Rating" LIKE '%5.3%' OR "Rating" LIKE '%5.4%' OR "Rating" LIKE '%5.5%' THEN 'Low 5th Class'
		WHEN "Rating" LIKE '%5.6%' THEN '5.6'
		WHEN "Rating" LIKE '%5.7%' THEN '5.7'
		WHEN "Rating" LIKE '%5.8%' THEN '5.8'
		WHEN "Rating" LIKE '%5.9%' THEN '5.9'
		WHEN "Rating" LIKE '%5.10a%' OR "Rating" LIKE '%5.10-%' THEN '5.10-'
		WHEN "Rating" LIKE '%5.10b%' OR "Rating" LIKE '%5.10c%' OR "Rating" LIKE '5.10' OR "Rating" LIKE '%5.10 %' THEN '5.10'
		WHEN "Rating" LIKE '%5.10d%' OR "Rating" LIKE '%5.10+%' THEN '5.10+'
		WHEN "Rating" LIKE '%5.11a%' OR "Rating" LIKE '%5.11-%' THEN '5.11-'
		WHEN "Rating" LIKE '%5.11b%' OR "Rating" LIKE '%5.11c%' OR "Rating" LIKE '5.11' OR "Rating" LIKE '%5.11 %' THEN '5.11'
		WHEN "Rating" LIKE '%5.11d%' OR "Rating" LIKE '%5.11+%' THEN '5.11+'
		WHEN "Rating" LIKE '%5.12a%' OR "Rating" LIKE '%5.12-%' THEN '5.12-'
		WHEN "Rating" LIKE '%5.12b%' OR "Rating" LIKE '%5.12c%' OR "Rating" LIKE '5.12' OR "Rating" LIKE '%5.12 %'THEN '5.12'
		WHEN "Rating" LIKE '%5.12d%' OR "Rating" LIKE '%5.12+%' THEN '5.12+'
		WHEN "Rating" LIKE '%5.13a%' OR "Rating" LIKE '%5.13-%' THEN '5.13-'
		WHEN "Rating" LIKE '%5.13b%' OR "Rating" LIKE '%5.13c%' OR "Rating" LIKE '5.13' OR "Rating" LIKE '%5.13 %'THEN '5.13'
		WHEN "Rating" LIKE '%5.13d%' OR "Rating" LIKE '%5.13+%' THEN '5.13+'
		WHEN "Rating" LIKE '%5.14a%' OR "Rating" LIKE '%5.14-%' THEN '5.14-'
		WHEN "Rating" LIKE '%5.14b%' OR "Rating" LIKE '%5.14c%' OR "Rating" LIKE '5.14' OR "Rating" LIKE '%5.14 %'THEN '5.14'
		WHEN "Rating" LIKE '%5.14d%' OR "Rating" LIKE '%5.14+%' THEN '5.14+'
		WHEN "Rating" LIKE '%5.15a%' OR "Rating" LIKE '%5.15-%' THEN '5.15-'
		WHEN "Rating" LIKE '%5.15b%' OR "Rating" LIKE '%5.15c%' OR "Rating" LIKE '5.15' OR "Rating" LIKE '%5.15 %'THEN '5.15'
		WHEN "Rating" LIKE '%5.15d%' OR "Rating" LIKE '%5.15+%'THEN '5.15+'
		ELSE 'Unknown'
		  END
	WHEN "Route Type" LIKE '%Boulder%' THEN
	  CASE
	    WHEN "Rating" LIKE '%V-easy%' THEN 'V-Easy'
		WHEN "Rating" LIKE '%V0%' THEN 'V0'
		WHEN "Rating" LIKE '%V1%' THEN 'V1'
		WHEN "Rating" LIKE '%V2%' THEN 'V2'
		WHEN "Rating" LIKE '%V3%' THEN 'V3'
		WHEN "Rating" LIKE '%V4%' THEN 'V4'
		WHEN "Rating" LIKE '%V5%' THEN 'V5'
		WHEN "Rating" LIKE '%V6%' THEN 'V6'
		WHEN "Rating" LIKE '%V7%' THEN 'V7'
		WHEN "Rating" LIKE '%V8%' THEN 'V8'
		WHEN "Rating" LIKE '%V9%' THEN 'V9'
		WHEN "Rating" LIKE '%V10%' THEN 'V10'
		WHEN "Rating" LIKE '%11%' THEN 'V11'
		WHEN "Rating" LIKE '%V12%' THEN 'V12'
		WHEN "Rating" LIKE '%V13%' THEN 'V13'
		WHEN "Rating" LIKE '%V14%' THEN 'V14'
		WHEN "Rating" LIKE '%V15%' THEN 'V15'
		WHEN "Rating" LIKE '%V16%' THEN 'V16'
		WHEN "Rating" LIKE '%V17%' THEN 'V17'
		ELSE 'Unknown'
	  END
    ELSE 'Crazy Winter Peeps Probably'
  END AS grades,
  "Location",
  COUNT("Location") AS ticks_per_location
  FROM user_ticklist_data
  GROUP BY grades, "Location"
  ORDER BY ticks_per_location DESC;

					



