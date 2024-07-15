-- TABLEAU TABLE
CREATE TABLE tableau_table_1 AS
	
-- Create CTE	
WITH new_signings (year,team,length,aav,age) AS (
	SELECT
		year,
		team_to,
		length,
		aav,
		age
	FROM historical_contracts
),

-- Adding contract amount category column
new_signings2 AS (	
	SELECT
		*,
		CASE
			WHEN aav >= 2000000 THEN 'significant'
			ELSE 'depth'
		END AS aav_category
	FROM new_signings
),

-- Adding Abbreviation to standings 
abbrev_standings AS (
	SELECT 
		historical_standings.*,
		teams.team_abbreviation
	FROM historical_standings
	JOIN teams ON historical_standings.team = teams.team_name
),

-- Adding primary key to standings
abbrev_standings2 AS (
	SELECT
		CONCAT(year,team_abbreviation) AS identifier,
		abbrev_standings.*
	FROM abbrev_standings
),

-- Adding foreign key to standings
new_signings3 AS (
	SELECT
		CONCAT(year,team) AS standings_id,
		new_signings2.*
	FROM new_signings2
),

-- Removing non significant contracts
new_signings4 AS (
	SELECT *
	FROM new_signings3
	WHERE aav_category='significant'
),

-- Aggregating data
new_signings5 AS (
	SELECT
		standings_id,
		max(year),
		max(team),
		COUNT(*) AS total_signings,
		AVG(length) AS avg_length,
		SUM(aav) AS total_spend,
		avg(age) AS avg_age
	FROM new_signings4
	GROUP BY standings_id
	ORDER BY standings_id
),
	
-- Adding pt% column
new_signings6 AS (
	SELECT
		abbrev_standings2.identifier,
		abbrev_standings2.year,
		abbrev_standings2.team,
		new_signings5.total_signings,
		new_signings5.avg_length,
		new_signings5.total_spend,
		new_signings5.avg_age,
		abbrev_standings2.percentage AS pt_percentage
	FROM abbrev_standings2
	FULL JOIN new_signings5 ON new_signings5.standings_id=abbrev_standings2.identifier
)
	
SELECT *
FROM new_signings6
WHERE identifier IS NOT NULL;

-- Update null values to 0

UPDATE tableau_table_1
SET total_signings=0
WHERE total_signings IS NULL;

UPDATE tableau_table_1
SET avg_length=0
WHERE avg_length IS NULL;

UPDATE tableau_table_1
SET total_spend=0
WHERE total_spend IS NULL;

UPDATE tableau_table_1
SET avg_age=0
WHERE avg_age IS NULL;

CREATE TABLE tableau_table AS
SELECT *
FROM tableau_table_1
ORDER BY identifier;