-- Creating table for employees
CREATE TABLE employee (
	emp_id INT PRIMARY KEY,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	age INT,
	birthdate DATE,
	gender VARCHAR(1)
	);

SELECT * FROM employee_salary;

-- Inserting datas for employee table
INSERT INTO employee VALUES (100, 'Joshua', 'Ulitin', 25, '1997-10-19', 'M');
INSERT INTO employee VALUES (101, 'Skye', 'Baldwin', 22, '2000-05-19', 'F');
INSERT INTO employee VALUES (102, 'Nelson', 'Hammond', 24, '1998-01-19', 'M');
INSERT INTO employee VALUES (103, 'Xzavier', 'Rich', 31, '1991-11-19', 'M');
INSERT INTO employee VALUES (104, 'Harold', 'Combs', 25, '1997-12-19', 'M');
INSERT INTO employee VALUES (105, 'Lucy', 'Greer', 19, '2003-09-19', 'F');
INSERT INTO employee VALUES (106, 'Emily', 'Estrada', 26, '1996-08-19', 'F');
INSERT INTO employee VALUES (107, 'Isaac', 'Ramirez', 25, '1997-02-19', 'M');
INSERT INTO employee VALUES (108, 'Chance', 'Jensen', 28, '1994-05-19', 'M');
INSERT INTO employee VALUES (109, 'Kamron', 'Reyes', 30, '1992-10-19', 'F');
INSERT INTO employee VALUES (110, 'Raul', 'Hester', 20, '2002-11-19', 'M');

-- Creating table for employee salary
CREATE TABLE employee_salary (
	emp_id INT,
	job_title VARCHAR(50),
	salary INT
	);

-- Inserting datas for employee salary
INSERT INTO employee_salary VALUES
(100, 'CEO', 100000),
(101, 'HR', 25000),
(102, 'Manager', 50000),
(103, 'Accountant', 30000),
(104, 'Salesman', 22000),
(105, 'Regional Manager', 60000),
(106, 'Accountant', 30000),
(107, 'Intern', 18000),
(108, 'Supplier Relations', 27000),
(109, 'Customer Service', 24000),
(110, 'Janitor', 20000);

-- Distinct
SELECT DISTINCT(gender)
FROM employee;

-- COUNT
SELECT COUNT(last_name) AS LastName
FROM employee;

-- Average salary
SELECT AVG(salary)
FROM employee_salary;

-- Looking for keywords using %
SELECT *
FROM employee
WHERE first_name LIKE '%osh%';

-- Using IN to display multiple rows in a table at once
SELECT *
FROM employee
WHERE first_name IN ('Joshua', 'Nelson');

-- Display the count of genders based on whether they are male or female
SELECT gender, COUNT(gender)
FROM employee
GROUP BY gender;

-- Inserting more datas on employee
INSERT INTO employee VALUES
(111, 'Todd', 'Ibarra', 22, NULL, NULL),
(112, 'Reyna', NULL, 24, '1996-08-09', 'F'),
(113, NULL, 'Atkins', 28, '1992-05-10', 'M');

-- Inserting more datas on employee salary
INSERT INTO employee_salary VALUES
(111, NULL, 24000),
(112, 'Salesman', NULL),
(113, 'Intern', NULL);

SELECT * FROM employee_salary
UPDATE employee_salary
SET emp_id = NULL
WHERE emp_id > 110;


-- JOINS
-- Using JOINS on employee and employee_salary table
-- INNER JOIN
SELECT *
FROM employee
INNER JOIN employee_salary
	ON employee.emp_id = employee_salary.emp_id;

-- LEFT JOIN
SELECT *
FROM employee
LEFT JOIN employee_salary
	ON employee.emp_id = employee_salary.emp_id;

-- RIGHT JOIN
SELECT *
FROM employee
RIGHT JOIN employee_salary
	ON employee.emp_id = employee_salary.emp_id;

-- FULL OUTER JOIN
SELECT *
FROM employee
FULL OUTER JOIN employee_salary
	ON employee.emp_id = employee_salary.emp_id;

-- Display the salary of employees except 'Joshua' sorted salary by descending
SELECT employee.emp_id, first_name, last_name, salary
FROM employee
INNER JOIN employee_salary
	ON employee.emp_id = employee_salary.emp_id
WHERE  first_name <> 'Joshua'
ORDER BY salary DESC;

-- UNIONS
-- Creating part_employee
CREATE TABLE part_employee (
	emp_id INT,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	age INT,
	birthdate DATE,
	gender VARCHAR(1)
	);

SELECT * FROM part_employee
ORDER BY age desc;

-- Inserting datas for part_employee
INSERT INTO part_employee VALUES 
	(150, 'Jillian', 'Fields', 28, '1992-01-08', 'F'),
	(151, 'Iris', 'Acevedo', 26, '1994-05-15', 'F'),
	(152, 'Francesca', 'Campbell', 31, '1991-10-15', 'F'),
	(153, 'Leonel', 'Donovan', 22, '2000-11-01', 'M'),
	(154, 'Crystal', 'Jacobson', 26, '1996-12-03', 'F'),
	(155, 'Albert', 'Jefferson', 19, '2003-04-15', 'M');

-- Inserting a similar row from employee to part_employee
INSERT INTO part_employee VALUES (100, 'Joshua', 'Ulitin', 25, '1997-10-19', 'M');

-- Union shows all datas from two tables except duplicates
SELECT *
FROM employee
UNION
SELECT *
FROM part_employee;

-- Union shows all similar datas from two tables except duplicates
SELECT *
FROM employee
UNION ALL
SELECT *
FROM part_employee;

-- Union can work with different column names as long as the data types are similar
SELECT emp_id, first_name, age
FROM employee
UNION
SELECT emp_id, job_title, salary
FROM employee_salary;
-- The problem is it takes literal values and will use the column name for the first table (ex: Salary is not the same as Age, but the data types are both int)

-- Case Statement
SELECT first_name, last_name, age,
CASE
	WHEN age > 30 THEN 'Adult'
	WHEN age BETWEEN 25 AND 30 THEN 'Young Adult'
	ELSE 'Young'
END
FROM employee
WHERE AGE IS NOT NULL
ORDER BY age;

-- Raise employee's salary depending on their job title
SELECT first_name, last_name, job_title, salary,
CASE
	WHEN job_title = 'Salesman' THEN salary + (salary * .10)
	WHEN job_title = 'Accountant' THEN salary + (salary * .05)
	WHEN job_title = 'HR' THEN salary + (salary * 0.001)
	ELSE salary + (salary * 0.03)
END AS SalaryAfterRaise
FROM employee
JOIN employee_salary
	ON employee.emp_id = employee_salary.emp_id;

-- Having Clause
--Check for job_titles that has more than 1 employee
SELECT job_title, COUNT(job_title)
FROM employee
JOIN employee_salary
	ON employee.emp_id = employee_salary.emp_id
GROUP BY job_title
HAVING COUNT(job_title) > 1;

-- Check for job_titles that has more than 40000 average salary
SELECT job_title, AVG(salary)
FROM employee
JOIN employee_salary
	ON employee.emp_id = employee_salary.emp_id
GROUP BY job_title
HAVING AVG(salary) > 40000
ORDER BY AVG(salary);

-- Updating rows
-- Set Job title for employee with salary of 24000
UPDATE employee_salary
SET job_title = 'Customer Service'
WHERE salary = 24000;

-- Insert birthdate and gender for employee with first_name 'Todd' and last_name 'Ibarra'
UPDATE employee
SET birthdate = '2000-03-05', gender = 'M'
WHERE first_name = 'Todd' AND last_name = 'Ibarra';

-- Checking table
SELECT * FROM employee;

-- Deleting rows
DELETE FROM employee
WHERE emp_id = 112;
-- Datas deleted cannot be restored and will be permanently gone from the database
-- Good practice is to use SELECT to see what datas you are deleting and then changing it to DELETE

-- Aliasing
-- Changes column name. Does not affect output, only used for better readability
SELECT first_name AS FirstName
FROM employee;

-- Combining first_name and last_name, aliasing both as FullName
SELECT first_name + ' ' + last_name AS FullName
FROM employee;

-- Using alias in aggregate functions
SELECT AVG(age) AS AvgAge
FROM employee;

-- Aliasing table names
SELECT Emp.emp_id, Sal.salary
FROM employee AS Emp
JOIN employee_salary AS Sal
	ON Emp.emp_id = Sal.emp_id;

-- Partition By
SELECT first_name, last_name, gender, salary, COUNT(gender) OVER (PARTITION BY gender) as TotalGender
FROM employee as Emp
JOIN employee_salary as Sal
	ON Emp.emp_id = Sal.emp_id

-- Partition by displays other columns while outputing the total count of gender
-- Group by can only display the column with the aggregate function (wihout first_name, last_name, and salary)

-- CTE (Common Table Expression)
-- A temporary result set used to manipulate subquery data

WITH CTE_Employee as (SELECT first_name, last_name, gender, salary, COUNT(gender) OVER (PARTITION BY gender) as TotalGender
FROM employee as Emp
JOIN employee_salary as Sal
	ON Emp.emp_id = Sal.emp_id
	)

SELECT *
FROM CTE_Employee;

-- Temp Tables

CREATE TABLE #temp_employee (
	emp_id INT,
	job_title VARCHAR(50),
	salary INT
	);

SELECT * FROM #temp_employee2;

-- You can insert every data from another table as long as the column matches
INSERT INTO #temp_employee
SELECT *
FROM employee_salary;

CREATE TABLE #temp_employee2 (
	job_title varchar(50),
	employees_per_job INT,
	avg_age INT,
	avg_salary INT)

INSERT INTO #temp_employee2
SELECT job_title, COUNT(job_title), AVG(age), AVG(salary)
FROM employee Emp
JOIN employee_salary Sal
	ON Emp.emp_id = Sal.emp_id
GROUP BY job_title;

-- String Functions (TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower)

CREATE TABLE employee_errors (
	emp_id VARCHAR(50),
	first_name VARCHAR(50),
	last_name VARCHAR(50)
	)

INSERT INTO employee_errors VALUES
('1001	', 'Jimbo', 'Halbert'),
('	1002', 'Pamela', 'Beasely'),
('1005', 'TOby', 'Flenderson - Fired');
-- Gets rid of blank spaces on both sides of valuye

-- Trims both sides
SELECT emp_id, TRIM(emp_id) as IDTRIM
FROM employee_errors

-- Trims left side
SELECT emp_id, LTRIM(emp_id) as IDTRIM
FROM employee_errors

-- Trims right side
SELECT emp_id, RTRIM(emp_id) as IDTRIM
FROM employee_errors

-- Using Replace
SELECT last_name, REPLACE (last_name, '- FIRED', '') as lastNameFixed
FROM employee_errors

-- Using Substring
SELECT SUBSTRING(first_name, 1,3)
FROM employee_errors

-- Inserting similar data for fuzzy matching
INSERT INTO employee_errors VALUES('1003', 'Joshua', 'Ulitin');
INSERT INTO employee_errors VALUES('1004', 'Harry', 'Common');


-- Fuzzy Matching
SELECT ERR.first_name, SUBSTRING(ERR.first_name, 1,3), EMP.first_name, SUBSTRING(EMP.first_name, 1,3)
FROM employee_errors ERR
JOIN employee EMP
	ON SUBSTRING(ERR.first_name, 1,3) = SUBSTRING(EMP.first_name, 1,3);

-- JOIN will work on substrings that has the same characters indicited. (1,3) means the first 3 letters, even though the full first name is not the same, it will still JOIN since the first 3 letters are.

-- Fuzzy matching is good to use on firstname, lastname, gender, age, and date of birth together (Don't just use the first name)'

-- Using UPPER and lower
SELECT lower(last_name)
FROM employee;

-- Using UPPER with Substring
SELECT UPPER(SUBSTRING(first_name, 1,3))
FROM employee;

-- Stored Procedures - A stored SQL code that can be reused over and over.
-- Similar to functions but you don't need a parameter, and don't have to return a result.
CREATE PROCEDURE TEST
AS
SELECT *
FROM employee;

-- Executes procedure
EXEC TEST

-- Creating a procedure that 1. Creates a temporary table with columns(job_title, employees_per_job, avg_age, avg_salary) 2. Inserting datas into the temporary table using JOINED table from employee and employee_salary
CREATE PROCEDURE temp_employee
AS
CREATE TABLE #temp_employee3 (
	job_title VARCHAR(100),
	employees_per_job INT,
	avg_age INT,
	avg_salary INT
	)

INSERT INTO #temp_employee3
SELECT job_title, COUNT(job_title), AVG(age), AVG(salary)
FROM employee EMP
JOIN employee_salary SAL
	ON EMP.emp_id = SAL.emp_id
GROUP BY job_title

SELECT *
FROM #temp_employee3
-- Modified procedure in Programmability > Stored Procedures > Modify
EXEC temp_employee @job_title = 'Salesman'

-- Subqueries / Nested Queries
SELECT * FROM employee_salary;

-- Subquery in SELECT
SELECT emp_id, salary, (SELECT AVG(salary) FROM employee_salary) AS AvgSalary
FROM employee_salary

-- How to do it with Partition By
SELECT emp_id, salary, AVG(salary) OVER () AS AvgSalary
FROM employee_salary

-- Why Group By doesn't work
SELECT emp_id, salary, AVG(salary) AS AvgSalary
FROM employee_salary
GROUP BY emp_id, salary
ORDER BY 1,2

-- Subquery in FROM
SELECT a.emp_id, AvgSalary
FROM (SELECT emp_id, salary, AVG(salary) OVER () AS AvgSalary
FROM employee_salary) AS a

-- Subquery in WHERE
SELECT emp_id, job_title, salary
FROM employee_salary
WHERE emp_id IN (
	SELECT emp_id
	FROM employee
	WHERE age > 30)
