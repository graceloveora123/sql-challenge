drop table public.departments;
drop table public.dept_emp;
drop table public.dept_manager;
drop table public.employees;
drop table public.salaries;
drop table public.titles;

create table departments(
	dept_no varchar(30) primary key,
	dept_name varchar(30) not null
);

create table titles(
	title_id varchar(30) primary key,
	title varchar(30) not null);

create table employees(
	emp_no integer primary key,
	emp_title_id varchar(30) not null,
	foreign key (emp_title_id) references titles(title_id),
	birth_date date not null,
	first_name	varchar(30) not null,
	last_name	varchar(30) not null,
	sex	 varchar(1),
	hire_date date not null);


create table dept_emp(
	emp_no integer not null,
	foreign key (emp_no) references employees(emp_no),
	dept_no varchar(30) not null,
	foreign key (dept_no) references departments(dept_no),
	primary key (emp_no, dept_no ));

create table dept_manager(
	dept_no varchar(30) not null,
	foreign key (dept_no) references departments(dept_no),
	emp_no integer not null,
	foreign key (emp_no) references employees(emp_no),
	primary key (dept_no,emp_no ));

create table salaries(
	emp_no integer not null,
	foreign key (emp_no) references employees(emp_no),
	salary integer not null);


select *
from public.departments
order by dept_no;

select *
from titles;

select count(*)
from employees;

select *
from employees;

select *
from public.dept_emp;

select *
from dept_manager;

select *
from salaries;

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT a.emp_no, a.last_name, a.first_name, a.sex, b.salary
from employees a left outer join salaries b
	on a.emp_no=b.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date
from employees 
where extract(year from hire_date)=1986;

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
select a.dept_no, b.dept_name, a.emp_no, c.last_name, c.first_name
from dept_manager a left outer join departments b on a.dept_no=b.dept_no
					left outer join employees c on a.emp_no=c.emp_no

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
select a.emp_no, a.last_name, a.first_name,c.dept_name
from employees a left outer join dept_emp b on a.emp_no=b.emp_no
				left outer join departments c on b.dept_no=c.dept_no

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex
from employees
where first_name='Hercules'
and last_name like 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select a.emp_no, a.last_name, a.first_name,c.dept_name
from employees a left outer join dept_emp b on a.emp_no=b.emp_no
				left outer join departments c on b.dept_no=c.dept_no
where b.dept_no='d007'

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select a.emp_no, a.last_name, a.first_name,c.dept_name
from employees a left outer join dept_emp b on a.emp_no=b.emp_no
				left outer join departments c on b.dept_no=c.dept_no
where b.dept_no in ('d005','d007')

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select count(last_name) as count_lm, last_name
from employees
group by last_name 
order by count(last_name) desc;








