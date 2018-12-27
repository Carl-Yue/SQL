-- Week 6 Demo  (Sub-Queries and putting it together)
-- Using Sportleagues database and Employees database
-- June 12th, 2018

-- Types of Queries
-- SCALAR  - Returns a single value
-- TABULAR - Returns a table with columns and rows

-- SCALAR EXAMPLE:
-- What was the most goals scored in one game by a single player...
SELECT MAX(NumGoals) AS "Max Goals"
FROM tbldatgoalscorers;

-- which player or players scored 5
SELECT DISTINCT playerID
FROM tbldatgoalscorers
WHERE NumGoals = (
    SELECT MAX(NumGoals) AS "Max Goals"
    FROM tbldatgoalscorers
    );
-- BUT, we need names...
SELECT namefirst, namelast
FROM tbldatplayers
WHERE playerid IN (
    SELECT DISTINCT playerID
    FROM tbldatgoalscorers
    WHERE NumGoals = (
        SELECT MAX(NumGoals) AS "Max Goals"
        FROM tbldatgoalscorers
        )
    )
ORDER BY namelast, namefirst;

-- List all employees that work in Seattle (Do not use joins)
-- First find the locationid for seattle
SELECT location_id
FROM locations 
WHERE UPPER(City) LIKE 'SEATTLE';
-- What departments are in location 1700 
-- (or whatever locationid got returned)
SELECT department_id 
FROM departments
WHERE location_ID IN (
    SELECT location_id
    FROM locations 
    WHERE UPPER(City) LIKE 'SEATTLE'
    );
-- Who works in these departments???
SELECT DISTINCT first_name, last_name
FROM employees
WHERE department_id IN (
    SELECT department_id 
    FROM departments
    WHERE location_ID IN (
        SELECT location_id
        FROM locations 
        WHERE UPPER(City) LIKE 'SEATTLE'
        )
    )
ORDER BY last_name, first_name;

-- stupid questions but, name all employees whom work in 
-- Seattle and their last name starts with "D"
SELECT first_name, last_name
FROM (
    SELECT DISTINCT first_name, last_name
    FROM employees
    WHERE department_id IN (
        SELECT department_id 
        FROM departments
        WHERE location_ID IN (
            SELECT location_id
            FROM locations 
            WHERE UPPER(City) LIKE 'SEATTLE'
            )
        )
    ORDER BY last_name, first_name
    )
WHERE UPPER(last_name) LIKE 'D%';


-- NOW LET'S HAVE SOME FUN
SELECT COUNT(gameid) AS "GP",
    hometeam AS tID,
    SUM(homescore) AS GF,
    SUM(visitscore) AS GA,
    SUM(CASE
        WHEN homescore > visitscore THEN 1
        ELSE 0
        END) AS Win,
    SUM(CASE
        WHEN homescore < visitscore THEN 1
        ELSE 0
        END) AS Loss,   
    SUM(CASE
        WHEN homescore = visitscore THEN 1
        ELSE 0
        END) AS Tie
FROM tbldatgames
WHERE isPlayed = 1
GROUP BY hometeam;
-- now for visitor teams
SELECT COUNT(gameid) AS "GP",
    visitteam AS tID,
    SUM(homescore) AS GF,
    SUM(visitscore) AS GA,
    SUM(CASE
        WHEN homescore < visitscore THEN 1
        ELSE 0
        END) AS Win,
    SUM(CASE
        WHEN homescore > visitscore THEN 1
        ELSE 0
        END) AS Loss,   
    SUM(CASE
        WHEN homescore = visitscore THEN 1
        ELSE 0
        END) AS Tie
FROM tbldatgames
WHERE isPlayed = 1
GROUP BY visitteam;

-- now union the previous two queries
SELECT COUNT(gameid) AS "GP",
    hometeam AS tID,
    SUM(homescore) AS GF,
    SUM(visitscore) AS GA,
    SUM(CASE
        WHEN homescore > visitscore THEN 1
        ELSE 0
        END) AS Win,
    SUM(CASE
        WHEN homescore < visitscore THEN 1
        ELSE 0
        END) AS Loss,   
    SUM(CASE
        WHEN homescore = visitscore THEN 1
        ELSE 0
        END) AS Tie
FROM tbldatgames
WHERE isPlayed = 1
GROUP BY hometeam

UNION

SELECT COUNT(gameid) AS "GP",
    visitteam AS tID,
    SUM(homescore) AS GF,
    SUM(visitscore) AS GA,
    SUM(CASE
        WHEN homescore < visitscore THEN 1
        ELSE 0
        END) AS Win,
    SUM(CASE
        WHEN homescore > visitscore THEN 1
        ELSE 0
        END) AS Loss,   
    SUM(CASE
        WHEN homescore = visitscore THEN 1
        ELSE 0
        END) AS Tie
FROM tbldatgames
WHERE isPlayed = 1
GROUP BY visitteam;

-- so now add it together (home and away)
SELECT SUM(GP) AS GP,
    TID AS TheTeamID,
    SUM(GF) AS GF,
    SUM(GA) AS GA,
    SUM(Win) AS W,
    SUM(Loss) AS L,
    SUM(Tie) AS T,
    SUM(Win) * 3 + SUM(Tie) AS Pts
    FROM (
SELECT COUNT(gameid) AS "GP",
    hometeam AS tID,
    SUM(homescore) AS GF,
    SUM(visitscore) AS GA,
    SUM(CASE
        WHEN homescore > visitscore THEN 1
        ELSE 0
        END) AS Win,
    SUM(CASE
        WHEN homescore < visitscore THEN 1
        ELSE 0
        END) AS Loss,   
    SUM(CASE
        WHEN homescore = visitscore THEN 1
        ELSE 0
        END) AS Tie
FROM tbldatgames
WHERE isPlayed = 1
GROUP BY hometeam

UNION

SELECT COUNT(gameid) AS "GP",
    visitteam AS tID,
    SUM(homescore) AS GF,
    SUM(visitscore) AS GA,
    SUM(CASE
        WHEN homescore < visitscore THEN 1
        ELSE 0
        END) AS Win,
    SUM(CASE
        WHEN homescore > visitscore THEN 1
        ELSE 0
        END) AS Loss,   
    SUM(CASE
        WHEN homescore = visitscore THEN 1
        ELSE 0
        END) AS Tie
FROM tbldatgames
WHERE isPlayed = 1
GROUP BY visitteam    
    )
    GROUP BY TID
    ORDER BY Pts DESC, W DESC, GF DESC;
    
-- now need team name - try 2 ways....
-- 1) with JOIN
-- 2) with Sub-query IN SELECT portion
SELECT SUM(GP) AS GP,
    TID AS TheTeamID,
    teamnameshort AS Team,
    SUM(GF) AS GF,
    SUM(GA) AS GA,
    SUM(Win) AS W,
    SUM(Loss) AS L,
    SUM(Tie) AS T,
    SUM(Win) * 3 + SUM(Tie) AS Pts
    FROM (
SELECT COUNT(gameid) AS "GP",
    hometeam AS tID,
    SUM(homescore) AS GF,
    SUM(visitscore) AS GA,
    SUM(CASE
        WHEN homescore > visitscore THEN 1
        ELSE 0
        END) AS Win,
    SUM(CASE
        WHEN homescore < visitscore THEN 1
        ELSE 0
        END) AS Loss,   
    SUM(CASE
        WHEN homescore = visitscore THEN 1
        ELSE 0
        END) AS Tie
FROM tbldatgames
WHERE isPlayed = 1
GROUP BY hometeam

UNION

SELECT COUNT(gameid) AS "GP",
    visitteam AS tID,
    SUM(homescore) AS GF,
    SUM(visitscore) AS GA,
    SUM(CASE
        WHEN homescore < visitscore THEN 1
        ELSE 0
        END) AS Win,
    SUM(CASE
        WHEN homescore > visitscore THEN 1
        ELSE 0
        END) AS Loss,   
    SUM(CASE
        WHEN homescore = visitscore THEN 1
        ELSE 0
        END) AS Tie
FROM tbldatgames
WHERE isPlayed = 1
GROUP BY visitteam    
    ) e
    JOIN tbldatteams ON tbldatteams.teamid = e.tid
    GROUP BY TID, teamnameshort
    ORDER BY Pts DESC, W DESC, GF DESC;
    
-- now using subquery
SELECT SUM(GP) AS GP,
    TID AS TheTeamID,
    (SELECT teamnameshort FROM tbldatteams WHERE teamid = TID) AS Team,
    SUM(GF) AS GF,
    SUM(GA) AS GA,
    SUM(Win) AS W,
    SUM(Loss) AS L,
    SUM(Tie) AS T,
    SUM(Win) * 3 + SUM(Tie) AS Pts
    FROM (
SELECT COUNT(gameid) AS "GP",
    hometeam AS tID,
    SUM(homescore) AS GF,
    SUM(visitscore) AS GA,
    SUM(CASE
        WHEN homescore > visitscore THEN 1
        ELSE 0
        END) AS Win,
    SUM(CASE
        WHEN homescore < visitscore THEN 1
        ELSE 0
        END) AS Loss,   
    SUM(CASE
        WHEN homescore = visitscore THEN 1
        ELSE 0
        END) AS Tie
FROM tbldatgames
WHERE isPlayed = 1
GROUP BY hometeam

UNION

SELECT COUNT(gameid) AS "GP",
    visitteam AS tID,
    SUM(homescore) AS GF,
    SUM(visitscore) AS GA,
    SUM(CASE
        WHEN homescore < visitscore THEN 1
        ELSE 0
        END) AS Win,
    SUM(CASE
        WHEN homescore > visitscore THEN 1
        ELSE 0
        END) AS Loss,   
    SUM(CASE
        WHEN homescore = visitscore THEN 1
        ELSE 0
        END) AS Tie
FROM tbldatgames
WHERE isPlayed = 1
GROUP BY visitteam    
    )
    GROUP BY TID
    ORDER BY Pts DESC, W DESC, GF DESC;