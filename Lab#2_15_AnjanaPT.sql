use COMPANY;
show tables;

/* 1.. Write a query to display all the countries.*/
select * from countries;


/* 2.. Write a query to display specific columns like email and phone number for all the employees. */
select email,phone_number from employees;


/* 3.. Write a query to display the data of employee whose last name is “Fay”. */
select * from employees where last_name = 'Fay';
select * from employees where last_name like "Fay";


/* 4.. Write a query to find the hire date for employees whose last name is “Grant” or “Whalen”.*/
select hire_date from employees where last_name = 'Grant' OR last_name = 'Whalen';
select hire_date from employees where last_name like 'Grant' OR last_name like "Whalen";


/* 5.. Write a query to display name of the employee who is shipping clerk.*/
select first_name,last_name from employees where job_id IN (select job_id from jobs where job_title = 'Shipping Clerk');
/* 5.. Write a query to display name of the employee who do not have a phone number.*/
select first_name,last_name from employees where phone_number IS NULL; 


/* 6.. Write a query to get all the employees who work for department 8.*/
 select * from employees where department_id like 8;
 select * from employees where department_id  = 8;


/* 7.. Write a query to display the departments in the descending order. */
 select * from dept ORDER BY department_name DESC;


/* 8.. Write a query to display all the employees whose last name starts with “K”.*/
select * from employees where last_name like 'K%';
 
 
/* 9.. Display name of the employees whose hire dates are between 1995 and 1997. */
select first_name,last_name from employees where year(hire_date) BETWEEN  '1995' AND '1997';


/* 10. Write a query to display jobs where the maximum salary is less than 5000. */
select * from jobs where max_salary < 5000;


/* 11.. Write a query to display email address in lower case.*/
 select LOWER(email) from employees;

 
/* 12.. Write a query to display name of the employees who were hired in 1995. */
select first_name,last_name from employees where hire_date like '1995%';
select first_name,last_name from employees where year(hire_date) like '1995' ;
select * from employees;


/* 13.. Write a query to insert an employee “Paul Newton” in department 11. */
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES 
(207,'Paul','Newton','paul.newton@sqltutorial.org','676.123.4567','2021-05-20',4,30000.00,106,11);
select * from employees where first_name = 'Paul' and last_name = 'Newton';


/* 14.. Write a query to delete the shipping department.*/
SET SQL_SAFE_UPDATES=0;
delete from dept where department_name = 'Shipping';
select * from dept;

/*select * from dept;
INSERT INTO dept(department_id,department_name,location_id) VALUES (5,'Shipping',1500);
SET SQL_SAFE_UPDATES=1;*/