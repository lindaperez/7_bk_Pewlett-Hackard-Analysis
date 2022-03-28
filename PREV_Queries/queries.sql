/*
--command " "\\copy public.departments (dept_no, dept_name) 
FROM '/Users/lindaperez/Desktop/Bootcamp/Module7SQL/pewlett-hackard-analysis/Data/departments.csv' 
DELIMITER ',' 
CSV HEADER QUOTE '\"'
ESCAPE '''';""


--command " "\\copy public.dept_emp (emp_no, dept_no, front_date, to_date) 
FROM '/Users/lindaperez/Desktop/Bootcamp/Module7SQL/pewlett-hackard-analysis/Data/dept_emp.csv' 
DELIMITER ',' CSV HEADER QUOTE '\"' ESCAPE '''';""*/


/* --command " "\\copy public.dept_manager (dept_no, emp_no, from_date, to_date) 
FROM '/Users/lindaperez/Desktop/Bootcamp/Module7SQL/pewlett-hackard-analysis/Data/dept_manager.csv' 
DELIMITER ',' CSV HEADER QUOTE '\"' ESCAPE '''';""

*/
-- SELECT * FROM Departments;	
-- SELECT * FROM Employees;	
-- SELECT * FROM Salaries;	
-- SELECT * FROM Titles;
-- SELECT * FROM Dept_emp;
-- SELECT * FROM dept_manager;	





-- DELETE FROM Titles;
-- DELETE FROM Dept_emp;
-- DELETE FROM salaries;
-- DELETE FROM employees;
-- DELETE FROM retirement_info;
-- DROP TABLE retirement_info;
-- Determine Retirement Eligibility

SELECT count(e.first_name)
		FROM employees e
		WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Narrow the Search for Retirement Eligibility
-- hire_date BETWEEN '1985-01-01' AND '1988-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND
	hire_date BETWEEN '1985-01-01' AND '1988-12-31';
	
-- Number of employees retiring -41380
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Create New Tables


SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND
	hire_date  BETWEEN '1985-01-01' AND '1988-12-31';
	
	
-- 7.3.2 Join the Tables	

	-- Employees with department
	SELECT e.emp_no, e.first_name || ' ' || e.last_name, d.dept_no, dd.dept_name 
	FROM Employees e LEFT JOIN Dept_Emp d ON e.emp_no = d.emp_no
	LEFT JOIN Departments dd ON d.dept_no = dd.dept_no;

	-- Employees by department (groupby)

	SELECT d.dept_no, d.dept_name, e.emp_no, e.first_name || ' ' || e.last_name
	FROM Departments d LEFT JOIN  Dept_Emp dd ON d.dept_no = dd.dept_no 
	LEFT JOIN Employees e ON e.emp_no = dd.emp_no
	GROUP BY d.dept_no,d.dept_name;


-- Crecreate the Retirement Info column including the emp_no column
DROP TABLE IF EXISTS retirement_info;

SELECT e.emp_no, e.first_name, e.last_name
INTO retirement_info
FROM employees e
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND
	e.hire_date  BETWEEN '1985-01-01' AND '1988-12-31';
	
-- Check the table 
SELECT * FROM retirement_info;


-- Use Different Types of Joins


-- 7.3.3 Joins in Action

	-- Use Inner Join for Departments and dept-manager Tables

	SELECT d.dept_name, m.emp_no, m.from_date, m.to_date
	FROM Departments d INNER JOIN Dept_manager m 
	ON d.dept_no = m.dept_no;


-- Use Left Join to Capture retirement-info Table


	/* Joining retirement_info and dept_emp tables: 
	  ADDING the date when the employee left d.to_date
	*/
	SELECT  r.emp_no, r.first_name,
			r.last_name, d.to_date
	FROM retirement_info r
		LEFT JOIN dept_emp  d 
		ON r.emp_no = d.emp_no;

	
-- 	Use Aliases for Code Readability 
	
-- 	Use Left Join for retirement_info and dept_emp tables
	/* CREATING CURRENT_EMP TABLE
	*/
	-- DROP TABLE current_emp ;

	SELECT  r.emp_no, r.first_name,
			r.last_name, d.to_date
	INTO current_emp
	FROM retirement_info r
		LEFT JOIN dept_emp  d 
		ON r.emp_no = d.emp_no
	WHERE d.to_date = ('9999-01-01');


-- NUMBER of currente employees 33118

	select COUNT(*) from current_emp;

	-- Number of employees by department 

	SELECT COUNT(e.emp_no), dd.dept_name
	FROM current_emp e LEFT JOIN Dept_emp d ON e.emp_no = d.emp_no
			   			LEFT JOIN Departments dd ON dd.dept_no = d.dept_no
	GROUP BY dd.dept_name;



SELECT COUNT(e.emp_no), dd.dept_name
FROM current_emp e LEFT JOIN Dept_emp d ON e.emp_no = d.emp_no
				   LEFT JOIN Departments dd ON dd.dept_no = d.dept_no
WHERE d.dept_no = 'd006'
GROUP BY dd.dept_name;




-- adding department to currenT_emp
DROP TABLE IF EXISTS current_emp;

SELECT  r.emp_no, r.first_name,
		r.last_name, dd.dept_name, d.to_date
INTO current_emp
FROM retirement_info r
	LEFT JOIN dept_emp  d 
	ON r.emp_no = d.emp_no
	LEFT JOIN departments dd 
	ON dd.dept_no = d.dept_no
WHERE d.to_date = ('9999-01-01');


-- 7.3.4 How many employees are retiring from sales deprtment 5252
DROP TABLE IF EXISTS dept_counts;
SELECT count(first_name) FROM current_emp
WHERE dept_name = 'Sales'

SELECT COUNT(e.emp_no), d.dept_no
INTO dept_counts
FROM current_emp e LEFT JOIN Dept_emp d ON e.emp_no = d.emp_no
GROUP BY d.dept_no
ORDER BY d.dept_no;

-- Exporting counts by department
/*
--command " "\\copy public.dept_counts (count, dept_no) 
TO '/Users/lindaperez/Desktop/Bootcamp/Module7SQL/pewlett-hackard-analysis/Data/dept_count.csv' 
DELIMITER ',' CSV HEADER QUOTE '\"' ESCAPE '''';""
*/

-- 7.3.5 Create Additional Lists

-- List 1: Employee Information
/* Employee Information: A list of employees containing their 
   unique employee number, their last name, first name, gender, and salary
*/

select * from salaries
order by to_date DESC;

SELECT e.emp_no,  e.first_name, e.last_name, e.gender
INTO emp_info
FROM employees e INNER JOIN salaries s ON e.emp_no = s.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')

drop table emp_info

SELECT e.emp_no,  e.first_name, e.last_name, e.gender, s.salary, de.to_date 
INTO emp_info
FROM employees e INNER JOIN salaries s ON e.emp_no = s.emp_no
				 INNER JOIN dept_emp de ON de.emp_no = e.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

select * from emp_info
-- List 2: Management
/*
Management: A list of managers for each department, including the department 
number, name, and the manager's employee number, last name, first name, and 
the starting and ending employment dates
*/
--DROP TABLE manager_info;
-- List of managers per department
SELECT m.dept_no, ce.dept_name, m.emp_no, ce.last_name, ce.first_name, m.from_date, m.to_date
 INTO manager_info
FROM dept_manager m INNER JOIN Departments d 
						ON d.dept_no = m.dept_no
					INNER JOIN current_emp ce 
						ON m.dept_no = d.dept_no and m.emp_no = ce.emp_no;
						
SELECT * FROM manager_info;	
		
-- List 3: Department Retirees  
/*
Department Retirees: An updated current_emp list that includes everything it currently has, but also the employee's departments
*/
--drop table dept_info;

SELECT  dd.dept_no, dd.dept_name, c.emp_no, c.first_name,
		c.last_name, d.to_date
 INTO dept_info
FROM current_emp c
	LEFT JOIN dept_emp  d 
	ON c.emp_no = d.emp_no
	LEFT JOIN Departments dd 
	ON dd.dept_no = d.dept_no;


--     What's going on with the salaries?
--     Why are there only five active managers for nine departments?
--     Why are some employees appearing twice?




-- # 7.3.6 Create a Tailored List


/*Create a query that will return only the information relevant to the Sales team. The requested list includes:

    Employee numbers
    Employee first name
    Employee last name
    Employee department name

End of text box. */
SELECT r.emp_no, r.first_name, r.last_name, d.dept_name FROM retirement_info r
LEFT JOIN dept_emp de on de.emp_no = r.emp_no
LEFT JOIN departments d on d.dept_no =de.dept_no
WHERE dept_name = 'Sales';


/*
Create another query that will return the following information for the Sales and Development teams:

    Employee numbers
    Employee first name
    Employee last name
    Employee department name

Hint: You'll need to use the IN condition with the WHERE clause. See the PostgreSQL documentation (Links to an external site.) for additional information.

The IN condition is necessary because you're creating two items in the same column.
*/


SELECT r.emp_no, r.first_name, r.last_name, d.dept_name FROM retirement_info r
LEFT JOIN dept_emp de on de.emp_no = r.emp_no
LEFT JOIN departments d on d.dept_no =de.dept_no
WHERE dept_name IN ('Sales','Development')
order by first_name, last_name;


-- Module 7 Challenge 

-- Background

-- Now that Bobby has proven his SQL chops, his manager has given both of you two more assignments: determine the 
-- number of retiring employees per title, and identify employees who are eligible to participate in a mentorship 
-- program. Then, you’ll write a report that summarizes your analysis and helps prepare Bobby’s manager for the 
-- “silver tsunami” as many current employees reach retirement age. 


-- What You're Creating

-- This new assignment consists of two technical analysis deliverables and a written report. You will submit the following:

--     Deliverable 1: The Number of Retiring Employees by Title
--     Deliverable 2: The Employees Eligible for the Mentorship Program
--     Deliverable 3: A written report on the employee database analysis (README.md)


--     Deliverable 1: The Number of Retiring Employees by Title

SELECT COUNT(DISTINCT r.emp_no), tt.title from retirement_info r
INNER JOIN titles tt ON tt.emp_no = r.emp_no
GROUP BY tt.title;

-- 	2037	"Assistant Engineer"
-- 	16111	"Engineer"
-- 	5	"Manager"
-- 	15600	"Senior Engineer"
-- 	14736	"Senior Staff"
-- 	14924	"Staff"
-- 	2014	"Technique Leader"


SELECT COUNT(r.emp_no) as total, r.emp_no, tt.title from retirement_info r
INNER JOIN titles tt ON tt.emp_no = r.emp_no
GROUP BY r.emp_no, tt.title
having COUNT(r.emp_no)>1;


-- 2037	"Assistant Engineer"
-- 16111	"Engineer"
-- 5	"Manager"
-- 15600	"Senior Engineer"
-- 14736	"Senior Staff"
-- 14924	"Staff"
-- 2013	"Technique Leader"


select * from employees 
where birth_date between '1952-01-01' and '1955-12-31'


select * from retirement_info
select * from titles

--     Deliverable 2: The Employees Eligible for the Mentorship Program



