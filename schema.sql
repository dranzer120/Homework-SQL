CREATE TABLE Employees(
	employee_id integer,
	birth_date date,
	first_name varchar,
	last_name varchar,
	gender varchar,
	hire_date date,
	Primary Key (employee_id)
);

CREATE TABLE Salaries(
	employee_id integer,
	salary integer,
	from_date date,
	to_date date,
	Primary Key (employee_id)
);

CREATE TABLE Titles(
	employee_id integer,
	title varchar,
	from_date date,
	to_date date,
	Primary Key (employee_id)
);

CREATE TABLE Departments(
	department_id varchar,
	department_name varchar,
	Primary Key (department_id)
);

CREATE TABLE Department_Manager(
	department_id varchar,
	employee_id integer,
	from_date date,
	to_date date,
	Primary Key (employee_id)
);

CREATE TABLE Department_Emp(
	employee_id integer,
	depatrment_id varchar,
	from_date date,
	to_date date,
	Primary Key (employee_id)
);

SELECT * FROM department_emp;
SELECT * FROM department_manager;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;


-- Question 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.employee_id,
	employees.last_name,
	employees.first_name,
	employees.gender,
	salaries.salary
FROM employees
INNER JOIN salaries ON
employees.employee_id = salaries.employee_id
ORDER BY employee_id ASC; 

-- Question 2. List employees who were hired in 1986.

SELECT * FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = '1986';


/* Question 3. List the manager of each department with the following information: department number, 
department name,the manager's employee number, last name, first name, and start and end employment dates.*/

SELECT department_manager.department_id,
	departments.department_name,
	department_manager.employee_id,
	employees.last_name,
	employees.first_name,
	department_manager.to_date
FROM ((department_manager
INNER JOIN employees ON department_manager.employee_id = employees.employee_id)
INNER JOIN departments ON department_manager.department_id = departments.department_id);

-- Q4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT department_emp.employee_id,
	employees.last_name,
	employees.first_name,
	departments.department_name
FROM ((department_emp
INNER JOIN employees ON department_emp.employee_id = employees.employee_id)
INNER JOIN departments ON department_emp.depatrment_id = departments.department_id);


--Q5 List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--Q6 List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT department_emp.employee_id,
	employees.last_name,
	employees.first_name,
	departments.department_name
FROM ((department_emp
INNER JOIN employees ON department_emp.employee_id = employees.employee_id)
INNER JOIN departments ON department_emp.depatrment_id = departments.department_id)
WHERE departments.department_name = 'Sales';

--Q7 List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT department_emp.employee_id,
	employees.last_name,
	employees.first_name,
	departments.department_name
FROM ((department_emp
INNER JOIN employees ON department_emp.employee_id = employees.employee_id)
INNER JOIN departments ON department_emp.depatrment_id = departments.department_id)
WHERE departments.department_name IN ('Sales', 'Development');

--Q8 In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;



