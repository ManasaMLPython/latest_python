-- Loan table
CREATE TABLE loan (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_amount DECIMAL(10,2),
    due_date DATE
);

-- Payments table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    loan_id INT REFERENCES loan(loan_id),
    payment_date DATE,
    amount_paid DECIMAL(10,2)
);
-- Insert sample loans
INSERT INTO loan (loan_id, customer_id, loan_amount, due_date) VALUES
(1, 101, 1000.00, '2024-06-30'),
(2, 102, 2000.00, '2024-07-15'),
(3, 103, 1500.00, '2024-07-01'),
(4, 104, 1200.00, '2024-06-20');

-- Insert sample payments
INSERT INTO payments (payment_id, loan_id, payment_date, amount_paid) VALUES
(1, 1, '2024-06-10', 300.00),
(2, 1, '2024-06-20', 700.00),  -- Fully paid, on time
(3, 2, '2024-07-10', 1000.00),
(4, 2, '2024-07-16', 1000.00), -- Fully paid, but 1 day late
(5, 3, '2024-06-25', 500.00),  -- Not fully paid
(6, 4, '2024-07-01', 1200.00); -- Fully paid, but after due date

--analyze loan repayment data to assess credit risk. Write an SQL to create 2 flags for each loan.
--fully_paid_flag: 1 if the loan was fully repaid irrespective of payment date else it should be 0.
-- on_time_flag: 1 if the loan was fully repaid on or before due date else 0.

WITH cte AS (
		SELECT l.loan_id,l.loan_amount, l.due_date,max(payment_date) payment_date, sum(amount_paid) as total_paid
		FROM loan l
		LEFT JOIN payments p
		ON p.loan_id = l.loan_id
		GROUP BY l.loan_id,l.loan_amount, l.due_date
		ORDER BY l.loan_id
)
SELECT loan_id, loan_amount, due_date,
	  CASE 
	  	WHEN total_paid=loan_amount THEN 1 ELSE 0
	  END AS fully_paid_flag,
	  CASE 
	  	WHEN payment_date<=due_date AND total_paid=loan_amount THEN 1 ELSE 0
	  END AS on_time_flag	
FROM cte;

























