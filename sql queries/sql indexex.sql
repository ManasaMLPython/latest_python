DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name TEXT,
    department TEXT,
    salary NUMERIC,
    join_date DATE
);

INSERT INTO employees (name, department, salary, join_date) VALUES
('Alice', 'HR', 50000, '2020-01-15'),
('Bob', 'Finance', 60000, '2019-03-12'),
('Charlie', 'Engineering', 75000, '2018-06-23'),
('Diana', 'Finance', 61000, '2021-08-11'),
('Eve', 'Engineering', 80000, '2017-09-30');

SELECT * FROM employees;

SELECT indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'public' AND tablename = 'employees';

EXPLAIN ANALYZE
SELECT * FROM employees WHERE department = 'Finance';
/* before index

"Seq Scan on employees  (cost=0.00..17.62 rows=3 width=104) (actual time=0.012..0.013 rows=2 loops=1)"
"  Filter: (department = 'Finance'::text)"
"  Rows Removed by Filter: 3"
"Planning Time: 0.058 ms"
"Execution Time: 0.025 ms"*/

CREATE INDEX idx_department ON employees(department);
