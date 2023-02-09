-- Create employee table
CREATE TABLE employee (
	employee_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	birth_date DATE,
	sex VARCHAR(1),
	salary INT,
	super_id INT,
	branch_id INT
	);

-- Create branch table
CREATE TABLE branch (
	branch_id INT PRIMARY KEY,
	branch_name VARCHAR(50),
	mgr_id INT,
	mgr_start_date DATE,
	FOREIGN KEY (mgr_id) REFERENCES employee(employee_id) ON DELETE SET NULL
	);

-- Set 'super_id' and 'branch_id' as FOREIGN KEYS in employee table
ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(employee_id)
ON DELETE SET NULL;

-- Creating client table
CREATE TABLE client (
	client_id INT PRIMARY KEY,
	client_name VARCHAR(50),
	branch_id INT,
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
	);

-- Creating works with table
CREATE TABLE works_with (
	employee_id INT,
	client_id INT,
	total_sales INT,
	PRIMARY KEY (employee_id, client_id),
	FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE,
	FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE CASCADE
	);

-- Creating branch supplier table
CREATE TABLE branch_supplier (
	branch_id INT,
	supplier_name VARCHAR(40),
	supply_type VARCHAR(40),
	PRIMARY KEY (branch_id, supplier_name),
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
	);

-- Inserting a corporate employee into the employee table
-- Corprate branch is not created yet, put null on branch_id first
INSERT INTO employee VALUES (100, 'Joshua', 'Ulitin', '1997-10-19', 'M', 20000, NULL, NULL);

-- Inserting values into branch (Corporate)
INSERT INTO branch VALUES (1, 'Corporate', 100, '2005-01-09');

-- Update corporate employee by setting 'branch_id' into 1
UPDATE employee
SET branch_id = 1
where employee_id = 100;

-- Inserting another corporate employee
INSERT INTO employee VALUES (101, 'John', 'Levinson', '1997-06-09', 'M', 15000, 100, 1);

-- Inserting a scranton employee
-- Scranton branch is not created yet, put null on branch_id first
INSERT INTO employee VALUES (102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

-- Inserting values into branch (Scranton)
INSERT INTO branch VALUES (2, 'Scranton', '102', '1992-04-06');

-- Update scranton employee by setting 'branch_id' into 2
UPDATE employee
SET branch_id = 2
where employee_id = 102;

-- Inserting three more scranton employees
INSERT INTO employee VALUES (103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 100, 2);
INSERT INTO employee VALUES (104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 100, 2);
INSERT INTO employee VALUES (105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 100, 2);

--Changing 'super_id' since I inserted the wrong value
UPDATE employee
SET super_id = 102
where employee_id = 103 OR employee_id = 104 OR employee_id = 105;

-- Checking table
SELECT * FROM employee;

-- Inserting a Stanford employee
-- Scranton branch is not created yet, put null on branch_id first
INSERT INTO employee VALUES (106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

-- Inserting values into branch (Stanford)
INSERT INTO branch VALUES (3, 'Stanford', '106', '1998-02-13');

-- Update stanford employee by setting 'branch_id' into 3
UPDATE employee
SET branch_id = 3
WHERE employee_id = 106;

-- Inserting two more stanford employees
INSERT INTO employee VALUES (107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES (108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

INSERT INTO branch_supplier VALUES (2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES (2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES (3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES (2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES (3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES (3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES (3, 'Stanford Labels', 'Custom Forms');

-- Inserting values into client
INSERT INTO client VALUES (400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES (401, 'Lackawana Country', 2);
INSERT INTO client VALUES (402, 'FedEx',3);
INSERT INTO client VALUES (403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES (404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES (405, 'Times Newspaper', 3);
INSERT INTO client VALUES (406, 'FedEx', 2);

-- Inserting values into works_with
INSERT INTO works_with VALUES (105, 400, 55000);
INSERT INTO works_with VALUES (102, 401, 267000);
INSERT INTO works_with VALUES (108, 402, 22500);
INSERT INTO works_with VALUES (107, 403, 5000);
INSERT INTO works_with VALUES (108, 403, 12000);
INSERT INTO works_with VALUES (105, 404, 33000);
INSERT INTO works_with VALUES (107, 405, 26000);
INSERT INTO works_with VALUES (102, 406, 15000);
INSERT INTO works_with VALUES (105, 406, 130000);

-- Check everything
SELECT * FROM works_with;

-- Simple tasks
-- Find all employees
SELECT * FROM employee;

-- Find all employees ordered by salary
SELECT * FROM employee
ORDER BY salary;

-- Find all employees ordered by sex then name
SELECT * FROM employee
ORDER BY sex, last_name, first_name;

-- Find the first 5 employee in the table
SELECT * FROM employee
ORDER BY employee_id -- Unnecessary
LIMIT 5;

-- Find the first and last names of all employees
SELECT first_name, last_name
FROM employee;

-- Find the forename and surnames names of all employees
SELECT first_name AS forename, last_name AS surname
FROM employee;

-- Find out all the different first names
SELECT DISTINCT first_name
FROM employee;

-- FUNCTIONS
-- Find the number of employees
SELECT COUNT(employee_id)
FROM employee;

-- Find the number of female employees born after 1970
SELECT COUNT(employee_id)
FROM employee
WHERE birth_date >= '1971-01-01' AND sex = 'F';

-- Find the average salaries of employees
SELECT AVG(salary)
FROM employee;

-- Find out how many males and females there are
SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

-- Find the total sales of each salesman
SELECT SUM(total_sales), employee_id
FROM works_with
GROUP BY employee_id;

--WILDCARDS
--Find any clients who are an LLC
SELECT *
FROM client
WHERE client_name LIKE '%LLC';

-- Find any branch suppliers who are in the label business
SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '%Label%';

-- Find any employee born in october
SELECT *
FROM employee
WHERE birth_date LIKE '_____10%';

-- Find any clients who are schools
SELECT *
FROM client
WHERE client_name LIKE '%school%';

-- UNIONS
-- Find a list of employee, branch, and client names
SELECT first_name
FROM employee
UNION
SELECT branch_name
FROM branch
UNION
SELECT client_name
FROM client;

-- Find a list of all clients & branch supplier's names and id's
SELECT client_name, branch_id
FROM client
UNION
SELECT supplier_name, branch_id
FROM branch_supplier;

-- Find a list of all money spent or earned by the company
SELECT salary AS MONEY
FROM employee
UNION
SELECT total_sales
FROM works_with;

-- Insert a branch to the table
INSERT INTO branch VALUES (4, 'Buffalo', NULL, NULL);

SELECT * FROM branch;
UPDATE branch
SET mgr_id = 106
WHERE branch_id = 3;
 
-- JOINS
-- Find all branches and the names of their managers
-- employee.'column name' is not required, used to easily identify which table the column name is coming from
SELECT employee.employee_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
WHERE employee.employee_id = branch.mgr_id;

-- NESTED QUERIES
-- Find names of all employees who have sold over 30,000 to a single client
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.employee_id IN (
	SELECT works_with.employee_id
	FROM works_with
	WHERE works_with.total_sales > 30000
);

-- Find supplier names and supply type who sold in branch_name stanford
SELECT supplier_name, supply_type
FROM branch_supplier
WHERE branch_supplier.branch_id IN (
	SELECT branch.branch_id
	FROM branch
	WHERE branch.branch_name = 'Stanford'
);

-- Find all clients who are handled by the branch that Michael Scott manages. Assume you know Michael's ID
SELECT client_name
FROM client
WHERE client.branch_id = (
	SELECT branch.branch_id
	FROM branch
	WHERE branch.mgr_id = 102
	LIMIT 1 -- Not required but is good to add if you're using equality operator
);

-- ON DELETE SET NULL, ON DELETE CASCADE
-- ON DELETE SET NULL - If you delete a row that uses a foreign key, the associated row value is automatically set to NULL
-- ON DELETE CASCADE - If you delete a row that uses a foreign key, the associated row will be deleted entirely.
DELETE FROM employee
WHERE employee_id = 102;

SELECT * FROM employee;

DELETE FROM branch
WHERE branch_id = 2;

SELECT * FROM branch_supplier;

-- TRIGGERS
CREATE TABLE trigger_test (
	message VARCHAR(100)
);
-- RUN THIS ON SQL Command Line
--DELIMITER $$ -- Changes the delimeter which is ';' that stops the query in mySQL into $$
--CREATE
--	TRIGGER my_trigger BEFORE INSERT
--	ON employee
--	FOR EACH ROW BEGIN
--		INSERT INTO trigger_test VALUES ('added new employee'); -- <<< this is the normal delimeter
--	END$$ -- << this is the new delimeter
--DELIMETER ; -- Turns delimeter back to ';'

INSERT INTO employee VALUES (109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

SELECT * FROM trigger_test;

-- Shows the first name added as trigger
--DELIMITER $$
--CREATE
--	TRIGGER my_trigger1 BEFORE INSERT
--	ON employee
--	FOR EACH ROW BEGIN
--		INSERT INTO trigger_test VALUES(NEW.first_name);
--	END $$
--DELIMETER ;

INSERT INTO employee VALUES (111, 'Post', 'Lamone', '1955-10-10', 'M', 611000, 107, 4);

SELECT * FROM trigger_test;

DELIMITER $$
CREATE
	TRIGGER my_trigger2 BEFORE INSERT
	ON employee
	FOR EACH ROW BEGIN
		IF NEW.sex = 'M' THEN
			INSERT INTO trigger_test VALUES ('added male employee');
		ELSEIF NEW.sex = 'F' THEN
			INSERT INTO trigger_test VALUES('added female employee');
		ELSE
			INSERT INTO trigger_test VALUES('added other employee');
		END IF;
	END $$
DELIMETER ;

INSERT INTO employee VALUES (112, 'Lance', 'Lot', '1968-03-05', 'M', 611000, 108, 3);
INSERT INTO employee VALUES (113, 'Hanabi', 'Cavite', '1955-11-03', 'F', 611000, 108, 3);

SELECT * FROM trigger_test;

SELECT * FROM employee;