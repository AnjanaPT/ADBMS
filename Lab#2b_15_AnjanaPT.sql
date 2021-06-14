use COMPANY;
show tables;


/*1. Write a query to display the number of cities in the country*/
SELECT country_id,COUNT(city) As NUMBER_OF_CITIES FROM Locations GROUP BY country_id;
select*from locations;


/*2. Write a query to display minimal salary of employees in every department*/
SELECT Department_id,MIN(salary) FROM Employees GROUP BY Department_id;
SELECT Department_name,MIN(salary) FROM Employees,Dept WHERE Employees.Department_id=Dept.Department_id GROUP BY Employees.Department_id;


/*3. Write a query to display maximum salary of employees in every department.*/
SELECT Department_id,MAX(salary) FROM Employees GROUP BY Department_id;
SELECT Department_name,MAX(salary) FROM Employees,Dept WHERE Employees.Department_id=Dept.Department_id GROUP BY Employees.Department_id;
/*SELECT Department_id,salary FROM Employees ;*/


/*4. Write a query to display sum of salary of employees in every department*/
SELECT Department_name,SUM(salary) FROM Employees,Dept WHERE Employees.Department_id=Dept.Department_id GROUP BY Employees.Department_id;
SELECT Department_id,SUM(salary) FROM Employees GROUP BY Department_id;


/*5. Display the ID of departments with average salary greater than 15000.*/
SELECT Department_id,AVG(salary) FROM Employees GROUP BY Department_id HAVING AVG(salary)>15000;


/*6. Write a query to display the number of employees managed by the manager.*/
SELECT Manager_id, COUNT(*) as Number_Of_Employees FROM Employees GROUP BY Manager_id HAVING Manager_id IS NOT NULL;


/*7. Write a query to display managers who are managing more than 3 employees.*/
SELECT Manager_id, COUNT(*) as NUMBER_OF_EMPLOYEES  FROM Employees GROUP BY Manager_id HAVING Manager_id IS NOT NULL AND COUNT(*)>3;


/*8. Write a query to increase salary of employee 111 to 5000.*/
SELECT employee_id,salary FROM employees WHERE employee_id=111;
UPDATE Employees SET salary=salary+5000 WHERE employee_id=111;
