-- DROP TABLE departments;
-- DROP TABLE titles;
-- DROP TABLE employees;
-- DROP TABLE dept_emp;
-- DROP TABLE dept_manager;
-- DROP TABLE salaries;

CREATE TABLE departments (
    dept_no VARCHAR(500) NOT NULL,
    dept_name VARCHAR(500) NOT NULL,
    PRIMARY KEY (dept_no)
);

CREATE TABLE titles (
    title_id VARCHAR(500) NOT NULL,
    title VARCHAR(500) NOT NULL,
    PRIMARY KEY (title_id)
);

-- created after the titles table due to foreign key constraint
CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR(500),
    birth_date DATE NOT NULL,
    first_name VARCHAR(500) NOT NULL,
    last_name VARCHAR(500) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

-- created after the departments and employees tables due to foreign key constraints
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no VARCHAR(500),
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

-- created after the departments and employees tables due to foreign key constraints
CREATE TABLE dept_manager (
    dept_no VARCHAR(500),
    emp_no INT,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- created after the employees tables due to foreign key constraints
CREATE TABLE salaries (
    emp_no INT,
    salary INT NOT NULL,
    PRIMARY KEY (emp_no, salary),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);



SELECT * FROM departments;
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;


-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no;


-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;


-- 3. List the manager of each department along with their department number, department name,
--    employee number, last name, and first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;


-- 4. List the department number for each employee along with that employee’s employee number, 
--    last name, first name, and department name.
SELECT dept_emp.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no;


-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose
--    last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT employees.emp_no, employees.last_name, employees.first_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';


-- 7. List each employee in the Sales and Development departments, including their employee number,
--    last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';


-- 8. List the frequency counts, in descending order, of all the employee last names
--    (that is, how many employees share each last name).
SELECT last_name, COUNT(*) as frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;





