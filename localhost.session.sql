-- SELECT statement

-- select all (*) columns from table
SELECT * FROM employees;
SELECT * FROM shops;
SELECT * FROM locations;
SELECT * FROM suppliers;

-- Employees who make more than 50k
SELECT *
FROM employees
WHERE salary > 50000;

-- Employees who work in Common Grounds coffeshop
SELECT *
FROM employees
WHERE coffeeshop_id = 1;

-- Employees who work in Common Grounds and make more than 50k
SELECT *
FROM employees
WHERE salary > 50000 AND coffeeshop_id = 1;

-- Employees who work in Common Grounds or make more than 50k
SELECT *
FROM employees
WHERE salary > 50000 OR coffeeshop_id = 1;

-- Employees who work in Common Grounds, make more than 50k and are male
SELECT *
FROM employees
WHERE
	salary > 50000
	AND coffeeshop_id = 1
	AND gender = 'M';

-- Employees who work in Common Grounds or make more than 50k or are male
SELECT *
FROM employees
WHERE
	salary > 50000
	OR coffeeshop_id = 1
	OR gender = 'M';

    --=======================================================

    -- All rows from the suppliers table where the supplier is Beans and Barley
SELECT *
FROM suppliers
WHERE supplier_name = 'Beans and Barley';

-- All rows from the suppliers table where the supplier is NOT Beans and Barley
SELECT *
FROM suppliers
WHERE NOT supplier_name = 'Beans and Barley';

SELECT *
FROM suppliers
WHERE supplier_name <> 'Beans and Barley';

-- All Robusta and Arabica coffee types
SELECT *
FROM suppliers
WHERE coffee_type IN ('Robusta', 'Arabica');

SELECT *
FROM suppliers
WHERE
	coffee_type = 'Robusta'
	OR coffee_type = 'Arabica';

-- All coffee types that are not Robusta or Arabica
SELECT *
FROM suppliers
WHERE coffee_type NOT IN ('Robusta', 'Arabica');

-- All employees with missing email addresses
SELECT *
FROM employees
WHERE email IS NULL;

-- All employees who make between 35k and 50k
SELECT
	employee_id,
	first_name,
	last_name,
	salary
FROM employees
WHERE salary BETWEEN 35000 AND 50000;

SELECT
	employee_id,
	first_name,
	last_name,
	salary
FROM employees
WHERE
	salary >= 35000
	AND salary <= 50000;

--===========================================================

-- Order by salary ascending 
SELECT
	employee_id,
	first_name,
	last_name,
	salary
FROM employees
ORDER BY salary;

-- Order by salary descending 
SELECT
	employee_id,
	first_name,
	last_name,
	salary
FROM employees
ORDER BY salary DESC;

-- Top 10 highest paid employees
SELECT
	employee_id,
	first_name,
	last_name,
	salary
FROM employees
ORDER BY salary DESC
LIMIT 10;

-- All unique coffeeshop ids
SELECT DISTINCT coffeeshop_id
FROM employees;

-- Return all unique countries
SELECT DISTINCT country
FROM locations;

-- Renaming columns
SELECT
	email,
	email AS email_address, 
	hire_date,
  hire_date AS date_joined,
	salary,
  salary AS pay
FROM employees;

--=========================================================
-- EXTRACT

SELECT
	hire_date as date,
	EXTRACT(YEAR FROM hire_date) AS year,
	EXTRACT(MONTH FROM hire_date) AS month,
	EXTRACT(DAY FROM hire_date) AS day
FROM employees;

--=========================================================


-- Concatenation, Boolean expressions, wildcards

-- Concatenate first and last names to create full names
SELECT
	first_name,
	last_name,
	first_name || ' ' || last_name AS full_name
FROM employees;

-- Lets create a sentence
SELECT 
	first_name || ' ' || last_name || ' makes ' || salary
FROM employees;

-- if the person makes less than 50k, then true, otherwise false
SELECT
	first_name || ' ' || last_name AS full_name,
	(salary < 50000) AS less_than_50k
FROM employees;

--===================================================


-- Select the minimum salary
SELECT MIN(salary) as min_sal
FROM employees;

-- Select the maximum salary
SELECT MAX(salary) as max_sal
FROM employees;

-- Difference between maximum and minimum salary
SELECT MAX(salary) - MIN(salary)
FROM employees;

-- Select the average salary
SELECT AVG(salary)
FROM employees;

-- Round average salary to nearest integer
SELECT ROUND(AVG(salary),0)
FROM employees;

-- Total salaries
SELECT SUM(salary)
FROM employees;

-- Count the number of entries
SELECT COUNT(*)
FROM employees;

SELECT COUNT(salary)
FROM employees;

SELECT COUNT(email)
FROM employees;

-- Summary
SELECT
  MIN(salary) as min_sal,
  MAX(salary) as max_sal,
  MAX(salary) - MIN(salary) as diff_sal,
  round(avg(salary), 0) as average_sal,
  sum(salary) as total_sal,
  count(*) as num_of_emp
FROM employees;

--=========================================================

-- Number of employees for each coffeeshop
SELECT
  coffeeshop_id,
	COUNT(employee_id)
FROM employees
GROUP BY coffeeshop_id;

-- Return the total salaries for each coffeeshop
SELECT
  coffeeshop_id,
	SUM(salary)
FROM employees
GROUP BY coffeeshop_id;

-- Return the number of employees, the avg & min & max & total salaries for each coffeeshop
SELECT
	coffeeshop_id, 
	COUNT(*) AS num_of_emp,
	ROUND(AVG(salary), 0) AS avg_sal,
	MIN(salary) AS min_sal,
    MAX(salary) AS max_sal,
	SUM(salary) AS total_sal
FROM employees
GROUP BY coffeeshop_id
ORDER BY num_of_emp DESC;

-- After GROUP BY, return only the coffeeshops with more than 200 employees
SELECT
	coffeeshop_id, 
	COUNT(*) AS num_of_emp,
	ROUND(AVG(salary), 0) AS avg_sal,
	MIN(salary) AS min_sal,
    MAX(salary) AS max_sal,
	SUM(salary) AS total_sal
FROM employees
GROUP BY coffeeshop_id
HAVING COUNT(*) > 200  -- filter, alter "where" after "gruop by"
ORDER BY num_of_emp DESC;

-- After GROUP BY, return only the coffeeshops with a minimum salary of less than 10k
SELECT
	coffeeshop_id, 
	COUNT(*) AS num_of_emp,
	ROUND(AVG(salary), 0) AS avg_sal,
	MIN(salary) AS min_sal,
    MAX(salary) AS max_sal,
	SUM(salary) AS total_sal
FROM employees
GROUP BY coffeeshop_id
HAVING MIN(salary) < 10000
ORDER BY num_of_emp DESC;

-- CASE SCENARIO
-- If pay is less than 50k, then low pay, otherwise high pay
SELECT
	employee_id,
	first_name || ' ' || last_name as full_name,
	salary,
	CASE
		WHEN salary < 50000 THEN 'low pay'
		WHEN salary >= 50000 THEN 'high pay'
		ELSE 'no pay'
	END as pay_category
FROM employees
ORDER BY salary DESC;

-- If pay is less than 20k, then low pay
-- if between 20k-50k inclusive, then medium pay
-- if over 50k, then high pay
SELECT
	employee_id,
	first_name || ' ' || last_name as full_name,
	salary,
	CASE
		WHEN salary < 20000 THEN 'low pay'
		WHEN salary BETWEEN 20000 and 50000 THEN 'medium pay'
		WHEN salary > 50000 THEN 'high pay'
		ELSE 'no pay'
	END as pay_category
FROM employees
ORDER BY salary DESC;

-- CASE & GROUP BY 
-- Return the count of employees in each pay category
SELECT a.pay_category, COUNT(*)
FROM(
	SELECT
		employee_id,
	    first_name || ' ' || last_name as full_name,
		salary,
    CASE
			WHEN salary < 20000 THEN 'low pay'
			WHEN salary BETWEEN 20000 and 50000 THEN 'medium pay'
			WHEN salary > 50000 THEN 'high pay'
			ELSE 'no pay'
		END as pay_category
	FROM employees
	ORDER BY salary DESC
) a
GROUP BY a.pay_category;

SELECT
	SUM(CASE WHEN salary < 20000 THEN 1 ELSE 0 END) AS low_pay,
	SUM(CASE WHEN salary BETWEEN 20000 AND 50000 THEN 1 ELSE 0 END) AS medium_pay,
	SUM(CASE WHEN salary > 50000 THEN 1 ELSE 0 END) AS high_pay
FROM employees;

-- 30 day moving total pay
-- Total_salary of employees who were hired "within" the 30-day period before the hire_date of the current employee
SELECT
	hire_date,
	salary,
	(
		SELECT SUM(salary)
		FROM employees e2
		WHERE e2.hire_date BETWEEN e1.hire_date - 30 AND e1.hire_date
	) AS pay_pattern
FROM employees e1
ORDER BY hire_date;

