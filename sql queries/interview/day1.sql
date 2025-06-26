-- 𝐂𝐫𝐞𝐚𝐭𝐞 𝐭𝐚𝐛𝐥𝐞 :-
DROP TABLE IF EXISTS Transactions;
CREATE TABLE Transactions (
 transaction_id INT PRIMARY KEY,
 day TIMESTAMP,
 amount INT
);
-- 𝐈𝐧𝐬𝐞𝐫𝐭 𝐯𝐚𝐥𝐮𝐞𝐬 
INSERT INTO Transactions (transaction_id, day, amount) VALUES
-- Provided by you
(8, '2021-04-03 15:57:28', 57),
(9, '2021-04-28 08:47:25', 21),
(1, '2021-04-29 13:28:30', 58),
(5, '2021-04-28 16:39:59', 40),
(6, '2021-04-29 23:39:28', 58),
(10, '2021-04-28 10:00:00', 21),
(11, '2021-04-28 11:00:00', 50),
(12, '2021-04-28 12:00:00', 50), 
(13, '2021-04-30 09:15:00', 30),
(14, '2021-04-30 11:45:00', 45),
(15, '2021-05-01 14:20:00', 70),
(16, '2021-05-01 17:00:00', 70),
(17, '2021-05-01 18:30:00', 50),
(18, '2021-05-02 08:00:00', 25);


SELECT * FROM Transactions;

--Write an SQL query to report the IDs of the transactions with the maximum amount on their respective day.
--If in one day there are multiple such transactions, return all of them.
WITH cte AS(
		SELECT day::DATE AS day, amount, transaction_id,
		DENSE_RANK() OVER(PARTITION BY day::DATE ORDER BY amount DESC) AS rnk
		FROM Transactions
)
SELECT day, amount, transaction_id FROM cte
WHERE rnk=1
ORDER BY day;