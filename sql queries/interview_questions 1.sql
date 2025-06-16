CREATE TABLE process_status (
    id VARCHAR(10),
    name VARCHAR(100),
    stts VARCHAR(50)
);
INSERT INTO process_status (id, name, stts) VALUES
('A', 'xyz', 'start'),
('A', 'xyz', 'I pending'),
('A', 'xyz', 'end'),
('B', 'xyz', 'start'),
('B', 'xyz', 'I pending'),
('B', 'xyz', 'E pending'),
('B', 'xyz', 'end');
--You're given a dataset like below, and you need to generate a new column seq such that all rows for a particular id get the same sequence number. 
--The sequence should increment for each distinct id.
SELECT *,
	   DENSE_RANK() OVER(ORDER BY id) AS seq
FROM process_status;