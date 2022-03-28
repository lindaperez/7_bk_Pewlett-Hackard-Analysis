DROP TABLE IF EXISTS Departments CASCADE;
DROP TABLE IF EXISTS Salaries;
DROP TABLE IF EXISTS Titles;
DROP TABLE IF EXISTS Employees CASCADE;
DROP TABLE IF EXISTS Dept_Emp CASCADE;
DROP TABLE IF EXISTS dept_manager CASCADE;


CREATE TABLE IF NOT EXISTS Departments(
		--dept_no INTEGER CONSTRAINT dept_pk PRIMARY KEY,
		dept_no varchar(4) NOT NULL,
	 	dept_name varchar(200) NOT NULL,
	PRIMARY KEY (dept_no)
);
CREATE TABLE IF NOT EXISTS Employees(
		emp_no INTEGER NOT NULL,
		birth_date date NOT NULL,
		first_name varchar(50) NOT NULL,
		last_name varchar(50) NOT NULL,
		gender char(1) NOT NULL,
		hire_date date NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE IF NOT EXISTS Dept_Emp (
	emp_no INTEGER NOT NULL,
	dept_no varchar(4) NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES Departments (dept_no),
	PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE IF NOT EXISTS Salaries (
	emp_no INTEGER NOT NULL,
	salary INTEGER NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
	PRIMARY KEY (emp_no)
);
CREATE TABLE IF NOT EXISTS Titles (
	emp_no INTEGER NOT NULL,
	title varchar NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);
CREATE TABLE IF NOT EXISTS dept_manager(
	dept_no varchar(4) NOT NULL,
	emp_no INTEGER NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES Departments (dept_no),
	PRIMARY KEY (dept_no, emp_no)
);

-- /*Alter table */
-- ALTER TABLE IF EXISTS Departments
-- 	ALTER COLUMN dept_no SET NOT NULL,
-- 	--ADD UNIQUE (dept_no),
-- 	ALTER COLUMN dept_no TYPE varchar(4),
-- 	ALTER COLUMN dept_name TYPE varchar(40),
-- 	ALTER COLUMN dept_name SET NOT NULL;

-- ALTER TABLE IF EXISTS Employees
-- 	DROP COLUMN IF EXISTS emp_no  CASCADE,
-- 	ADD COLUMN emp_no INTEGER,
-- 	ADD PRIMARY KEY (emp_no),
-- 	ADD UNIQUE (emp_no),
-- 	ALTER COLUMN emp_no SET NOT NULL,
-- 	DROP COLUMN IF EXISTS birth_day,
-- 	ADD COLUMN IF NOT EXISTS birth_date DATE,
-- 	ALTER COLUMN birth_date SET NOT NULL,
-- 	ALTER COLUMN first_name SET NOT NULL,
-- 	ALTER COLUMN last_name SET NOT NULL,
-- 	ALTER COLUMN gender SET NOT NULL,
-- 	ALTER COLUMN gender TYPE varchar,
-- 	DROP COLUMN IF EXISTS hide_date,
-- 	ADD COLUMN hire_date DATE,
-- 	ALTER COLUMN hire_date SET NOT NULL;

-- ALTER TABLE IF EXISTS Dept_Emp
-- 	DROP COLUMN emp_no,
-- 	ADD COLUMN emp_no INTEGER,
-- 	ADD CONSTRAINT deptEmp_employee_emp_no_fk FOREIGN KEY (emp_no) 
-- 	REFERENCES Employees (emp_no);
	
	
-- ALTER TABLE IF EXISTS Salary
-- 	DROP COLUMN emp_no,
-- 	ADD COLUMN emp_no INTEGER,
-- 	ADD CONSTRAINT salary_employee_emp_no_fk 
-- 	FOREIGN KEY (emp_no) 
-- 	REFERENCES Employees (emp_no);
	
-- ALTER TABLE IF EXISTS Title
-- 	DROP COLUMN emp_no,
-- 	ADD COLUMN emp_no INTEGER,
-- 	ADD CONSTRAINT title_employees_emp_no_fk
-- 	FOREIGN KEY (emp_no) REFERENCES Employees (emp_no);
	
SELECT * FROM current_emp;
SELECT * FROM Departments;	
SELECT * FROM Employees;	
SELECT * FROM Salaries;	
SELECT * FROM Titles;
SELECT * FROM Dept_emp;
SELECT * FROM dept_manager;	

	

	