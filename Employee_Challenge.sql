	/*Total number of employees with the criteria including employees already retired 90398*/
	select count(DISTINCT e.emp_no) from employees e
	WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
	
	/*Total number of distinct employees with different job titles with the criteria 
	including already retired employees 90398 */
	SELECT count( e.emp_no)
	FROM employees e INNER JOIN titles tt ON tt.emp_no = e.emp_no
	WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'


/* Deliverable 1 The Number of Retiring Employees by Title  */

/* Employees who are born between January 1, 1952 and December 31, 1955*/
-- The Retirement Titles table is exported as retirement_titles.csv
SELECT e.emp_no, e.first_name, e.last_name, tt.title, tt.from_date, tt.to_date
--INTO retirement_titles 
FROM employees e INNER JOIN titles tt ON tt.emp_no = e.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no ASC;


/* Table with the employee number, first and last name, and most recent title*/
-- The Unique Titles table is exported as unique_titles.csv
SELECT DISTINCT ON (rt.emp_no) rt.emp_no, rt.first_name, rt.last_name, rt.title
-- INTO unique_titles
FROM retirement_titles rt 
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no ASC, rt.last_name DESC;


/*Retiring Titles table that contains the number of titles filled by employees who are retiring.*/
-- The Retiring Titles table is exported as retiring_titles.csv
SELECT COUNT (u.emp_no), u.title
-- INTO retiring_titles
FROM unique_titles u 
GROUP BY u.title
ORDER BY COUNT (u.emp_no) DESC










/* Deliverable 2:The Employees Eligible for the Mentorship Program */

/* Mentorship Eligibility table for current employees who were born between January 1, 1965 and December 31, 1965*/
-- The Mentorship Eligibility table is exported and saved as  mentorship_eligibilty.csv
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, tt.title
--INTO mentorship_eligibilty
FROM employees e
LEFT JOIN dept_emp de ON de.emp_no = e.emp_no
LEFT JOIN  titles tt ON tt.emp_no = de.emp_no
WHERE tt.to_date = '9999-01-01' AND 
e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no 


/*SUMMARY */
--  How many roles will need to be filled as the "silver tsunami" begins to make an impact?

SELECT COUNT ( DISTINCT u.emp_no) --72458
FROM unique_titles u 
--   The amount of roles that need to be filled is 72458


-- Are there enough qualified, retirement-ready employees in the departments to mentor the next 
-- generation of Pewlett Hackard employees?
-- No, there are only 1549


SELECT COUNT(DISTINCT e.emp_no) --1549
FROM employees e
LEFT JOIN dept_emp de ON de.emp_no = e.emp_no
LEFT JOIN  titles tt ON tt.emp_no = de.emp_no
WHERE tt.to_date = '9999-01-01' AND 
e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'



SELECT  COUNT(DISTINCT e.emp_no), tt.title
FROM employees e
LEFT JOIN dept_emp de ON de.emp_no = e.emp_no
LEFT JOIN  titles tt ON tt.emp_no = de.emp_no
WHERE tt.to_date = '9999-01-01' AND 
e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
GROUP BY tt.title
ORDER BY tt.title

