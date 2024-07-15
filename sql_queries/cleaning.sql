-- Viewing/Exploring each table
SELECT * FROM historical_contracts;
SELECT * FROM historical_standings;
SELECT * FROM teams;

-- Cleaning

-- Eliminating Null columns
SELECT * FROM historical_contracts WHERE name IS NULL;
SELECT * FROM historical_standings WHERE team IS NULL;

DELETE FROM historical_contracts WHERE name IS NULL;
DELETE FROM historical_standings WHERE team IS NULL;

-- Adjusting aav column to int
SELECT * FROM historical_contracts WHERE length(aav)<5;
DELETE FROM historical_contracts WHERE length(aav)<3;

ALTER TABLE historical_contracts ALTER COLUMN aav TYPE numeric(10,2) USING (to_number(aav,'L99G999G999D99'));

-- Deleting inaccurate data
SELECT year FROM historical_contracts WHERE year>2023 OR year<2012;
SELECT name FROM historical_contracts WHERE length(name)<5;
SELECT position FROM historical_contracts WHERE position<>'F' AND position<>'C' AND position<>'RW' AND position<>'LW' AND position<>'D' AND position<>'G';
SELECT age FROM historical_contracts WHERE age>47 OR age<18;
DELETE FROM historical_contracts WHERE age>47 OR age<18;
SELECT team_from FROM historical_contracts WHERE length(team_from)<>3;
SELECT team_to FROM historical_contracts WHERE length(team_to)<>3;
SELECT length FROM historical_contracts WHERE length>14 OR length<1;
SELECT aav FROM historical_contracts WHERE aav>15000000 OR aav<500000;
DELETE FROM historical_contracts WHERE aav>15000000 OR aav<500000;

SELECT year FROM historical_standings WHERE year>2024 OR year<2012;
SELECT team FROM historical_standings WHERE length(team)<10;
SELECT rank FROM historical_standings WHERE rank>32 OR rank<1;
SELECT gp FROM historical_standings WHERE gp<48 AND gp>82;
SELECT w FROM historical_standings WHERE w>82 OR w<10;
SELECT l FROM historical_standings WHERE l>82 OR l<5;
SELECT otl FROM historical_standings WHERE otl>20;
SELECT pts FROM historical_standings WHERE pts>150 OR pts<20;
SELECT percentage FROM historical_standings WHERE percentage>1 OR percentage<0;

-- Fixing inconsistencies caused by PHX-ARI name change
UPDATE historical_contracts SET 
	team_from = REPLACE(team_from,'PHX','ARI');
UPDATE historical_contracts SET 
	team_to = REPLACE(team_to,'PHX','ARI');
UPDATE historical_standings SET 
	team = REPLACE(team,'Phoenix Coyotes','Arizona Coyotes');


