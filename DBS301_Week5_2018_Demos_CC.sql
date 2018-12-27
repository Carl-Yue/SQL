-- Week 5 Demo 
-- Using Sportleagues database
-- June 5th, 2018

SELECT * FROM tbldatplayers;
SELECT Count(playerid) FROM tbldatplayers;

SELECT * FROM tbldatteams;
SELECT COUNT(teamID) FROM tbldatteams;

SELECT * FROM tbljncRosters;
SELECT COUNT(rosterID) from tbljncrosters;

-- let's add names to the rosters
SELECT rosterid, tbljncrosters.playerid, teamid, tbljncrosters.isactive, 
    jerseynumber, namefirst, namelast
    FROM tbldatplayers, tbljncrosters
    WHERE tbljncrosters.playerid = tbldatplayers.playerid;
    
-- Let's use JOINS instead to be more efficient

-- 4 types  (INNER, LEFT OUTER, RIGHT OUTER, FULL OUTER)
-- INNER
SELECT rosterid, tbljncrosters.playerid, teamid, tbljncrosters.isactive, 
    jerseynumber, namefirst, namelast
    FROM tbldatplayers INNER JOIN tbljncrosters
    ON tbljncrosters.playerid = tbldatplayers.playerid
   ;
-- LEFT OUTER
SELECT rosterid, tbljncrosters.playerid, teamid, tbljncrosters.isactive, 
    jerseynumber, namefirst, namelast
    FROM tbldatplayers LEFT OUTER JOIN tbljncrosters
    ON tbljncrosters.playerid = tbldatplayers.playerid
   ;
-- RIGHT OUTER
SELECT rosterid, tbljncrosters.playerid, teamid, tbljncrosters.isactive, 
    jerseynumber, namefirst, namelast
    FROM tbldatplayers RIGHT OUTER JOIN tbljncrosters
    ON tbljncrosters.playerid = tbldatplayers.playerid
   ;
-- FULL OUTER
SELECT rosterid, tbljncrosters.playerid, teamid, tbljncrosters.isactive, 
    jerseynumber, namefirst, namelast
    FROM tbldatplayers FULL OUTER JOIN tbljncrosters
    ON tbljncrosters.playerid = tbldatplayers.playerid
   ;
   
   
-- let us display all players NOT currently on a roster
SELECT rosterid, tbljncrosters.playerid, teamid, tbljncrosters.isactive, 
    jerseynumber, namefirst, namelast
    FROM tbldatplayers LEFT OUTER JOIN tbljncrosters
    ON tbljncrosters.playerid = tbldatplayers.playerid
    WHERE rosterid IS NULL
   ;


-- Let's show rosters showing both team and player names
SELECT rosterid, tbljncrosters.playerid, tbljncrosters.teamid, tbljncrosters.isactive, 
    jerseynumber, namefirst, namelast, teamnameshort
    FROM (tbldatplayers JOIN tbljncrosters 
        ON tbljncrosters.playerid = tbldatplayers.playerid) 
        JOIN tbldatteams ON tbljncrosters.teamid = tbldatteams.teamid
        ORDER BY teamnameshort, namelast, namefirst;

-- Let's print an individual team roster
SELECT rosterid, tbljncrosters.playerid, tbljncrosters.teamid, tbljncrosters.isactive, 
    jerseynumber, namefirst, namelast, teamnameshort
    FROM (tbldatplayers JOIN tbljncrosters 
        ON tbljncrosters.playerid = tbldatplayers.playerid) 
        JOIN tbldatteams ON tbljncrosters.teamid = tbldatteams.teamid
        WHERE tbldatteams.teamid = 214
        ORDER BY namelast, namefirst;
-- BUT THAT's a hard coded teamID, I want to choose
SELECT rosterid, tbljncrosters.playerid, tbljncrosters.teamid, tbljncrosters.isactive, 
    jerseynumber, namefirst, namelast, teamnameshort
    FROM (tbldatplayers JOIN tbljncrosters 
        ON tbljncrosters.playerid = tbldatplayers.playerid) 
        JOIN tbldatteams ON tbljncrosters.teamid = tbldatteams.teamid
        WHERE tbldatteams.teamid = &teamID
        ORDER BY namelast, namefirst;
-- But this is sort of useless as I don't always know team ID
SELECT rosterid, tbljncrosters.playerid, tbljncrosters.teamid, tbljncrosters.isactive, 
    jerseynumber, namefirst, namelast, teamnameshort
    FROM (tbldatplayers JOIN tbljncrosters 
        ON tbljncrosters.playerid = tbldatplayers.playerid) 
        JOIN tbldatteams ON tbljncrosters.teamid = tbldatteams.teamid
        WHERE tbldatteams.teamnameshort = '&TeamName'
        ORDER BY namelast, namefirst;
-- But maybe only part of the name
SELECT rosterid, tbljncrosters.playerid, tbljncrosters.teamid, tbljncrosters.isactive, 
    jerseynumber, namefirst, namelast, teamnameshort
    FROM (tbldatplayers JOIN tbljncrosters 
        ON tbljncrosters.playerid = tbldatplayers.playerid) 
        JOIN tbldatteams ON tbljncrosters.teamid = tbldatteams.teamid
        WHERE UPPER(tbldatteams.teamnameshort) LIKE UPPER('%&TeamName%')
        ORDER BY namelast, namefirst;
        
-- BUT was teamID required in the SELECT portion of the statement... answer "NO"
SELECT rosterid, tbljncrosters.playerid, tbljncrosters.isactive, 
    jerseynumber, namefirst, namelast, teamnameshort
    FROM (tbldatplayers JOIN tbljncrosters 
        ON tbljncrosters.playerid = tbldatplayers.playerid) 
        JOIN tbldatteams ON tbljncrosters.teamid = tbldatteams.teamid
        WHERE UPPER(tbldatteams.teamnameshort) LIKE UPPER('%&TeamName%')
        ORDER BY namelast, namefirst;