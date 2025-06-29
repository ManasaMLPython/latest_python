DROP TABLE IF EXISTS teams;
CREATE TABLE teams (
    col1 VARCHAR(10)
);
INSERT INTO teams (col1) VALUES 
('RCB'), 
('CSK'), 
('MI'), 
('PBKS');

SELECT * FROM teams;
/*
We need to generate a match schedule such that:
 • Each team plays with every other team exactly once
 • No duplicate combinations (e.g., if RCB vs CSK is listed, CSK vs RCB shouldn't be repeated)

🎯 Expected Output Example:
team1  | team2 
------- |-------- 
RCB   | CSK 
RCB   | MI 
RCB   | PBKS 
CSK   | MI 
CSK   | PBKS 
MI    | PBKS 
*/

SELECT t1.col1 AS team1, t2.col1 AS team2
FROM teams t1
CROSS JOIN teams t2
WHERE t1.col1 > t2.col1;