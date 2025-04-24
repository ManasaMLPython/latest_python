DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	id SERIAL PRIMARY KEY,
	name TEXT,
	salary NUMERIC
)

-- INSERT DATA
INSERT INTO employees(name,salary) VALUES
('Alice', 50000),
('Bob', 60000),
('Charlie', 55000);

SELECT * FROM employees;

--Procedure 1: Insert New Employee

CREATE OR REPLACE PROCEDURE insert_data(emp_name TEXT, emp_salary NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO employees(name,salary) values(emp_name, emp_salary);
END;
$$;
CALL insert_data('COB', 50000);
CALL insert_data('Eve',70000);

--Procedure 2: Increase Salary by Fixed Amount

CREATE OR REPLACE PROCEDURE salary_inc(emp_id INT, raise_salary NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE employees
	SET salary=raise_salary
	WHERE id=emp_id;
END;
$$;
CALL salary_inc(1,10000);

-- Procedure 3: Show Employee Salary (Using RAISE NOTICE)

CREATE OR REPLACE PROCEDURE show_sal(emp_name TEXT)
LANGUAGE PLPGSQL
AS $$
DECLARE emp_sal NUMERIC;
BEGIN
	SELECT salary INTO emp_sal FROM employees WHERE name=emp_name;
	IF emp_sal IS NOT NULL THEN
			RAISE NOTICE '% earns %', emp_name, emp_sal;
	ELSE
		RAISE NOTICE 'employee not found';
	END IF;
END;
$$;
CALL show_sal('COB');

-- OUT PARAM

CREATE OR REPLACE PROCEDURE square(IN n INT, out s INT)
LANGUAGE PLPGSQL
AS $$
BEGIN
	s:=n*n;
END;
$$;
CALL square(3,NULL);

/*EXERCISE 1: Grade Checker (IF / ELSIF / ELSE)
Write a procedure that takes a score and outputs a grade:

90+ → "A"

80-89 → "B"

70-79 → "C"*/

CREATE OR REPLACE PROCEDURE grade_checker(IN score INT, OUT grade TEXT)
LANGUAGE PLPGSQL
AS $$
BEGIN
	IF score>=90 THEN
		grade := 'A+';
	ELSIF score>=80 AND score<=89 THEN
		grade := 'B';
	ELSE
		grade := 'C';
	END IF;
END;
$$;
CALL grade_checker(60,NULL);

-- LOOPS
--EXERCISE 1: Print Numbers 1 to 5 (BASIC LOOP)
CREATE OR REPLACE PROCEDURE print_nums(IN n NUMERIC)
LANGUAGE PLPGSQL
AS $$
DECLARE
	i NUMERIC;
BEGIN
	i:=1;
	LOOP
		RAISE NOTICE 'i=%',i;
		i := i+1;
		EXIT WHEN i>n;
	END LOOP;
END;
$$;
CALL print_nums(10);

--EXERCISE 2: Sum 1 to N (WHILE LOOP)
CREATE OR REPLACE PROCEDURE sum_nums(IN n NUMERIC, OUT s NUMERIC)
LANGUAGE PLPGSQL
AS $$
DECLARE
	i NUMERIC :=1;
	
BEGIN
	s := 0;
	WHILE i<=n LOOP
		s := s+i;
		i := i+1;
	END LOOP;
END;
$$;
CALL sum_nums(2,NULL);
		
