**Introduction**

This project delves into the coffee market, focusing on the sales performance of the top 4 coffee brands. Using SQL, to explore and analyze employee salary conditions, performing data cleaning, table creation, and running queries to gain insights. Additionally, I use Excel to create a comprehensive dashboard to visualize sales trends, providing a clear overview of market dynamics and brand performance.

**The questions I wanted to answer through my SQL queries were:**

**1.	What are the top highest paid employees?**

    -- Top 10 highest paid employees
    SELECT
	employee_id,
	first_name,
	last_name,
	salary
    FROM employees
    ORDER BY salary DESC
    LIMIT 10;
    
![Untitled1](https://github.com/user-attachments/assets/a54a943c-777c-459e-b4fc-e4be44eee0b8)


**2.	Number of employees working, the maximum and minimum salary, the average salary , in the industry?**

     -- Select the maximum salary
    SELECT MIN(salary) as min_sal
    FROM employees;
    Select the maximum salary
    SELECT MAX(salary) as max_sal
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

    -- Summary Return the number of employees, the avg & min & max & total salaries for each coffeeshop
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
    
![Untitled2](https://github.com/user-attachments/assets/2c76c52d-6396-49ec-8ca0-1d4eee3b1406)

    

3.	**Identify as per parameters the salaries as High paid, Medium paid and Low pay.**

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

![Untitled3](https://github.com/user-attachments/assets/57751a12-0fe9-4489-9cee-abd4d89f071b)

4. **Total salary of employees who were hired 30 days before the hire date**
   
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

![Untitled4](https://github.com/user-attachments/assets/8246455b-7591-4026-ba40-dffc013d1467)
