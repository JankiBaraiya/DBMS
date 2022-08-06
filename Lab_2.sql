--------Lab 2--------
select * from Employee;

--1. Display all the employees whose name starts with “m” and 4 th character is “h”.
	Select * from Employee
	where EName like'm__h%';

--2. Find the value of 3 raised to 5. Label the column as output.
	select power(3,5);
	
--3. Write a query to subtract 20 days from the current date.
	select getdate()-20;

--4. Write a query to display name of employees whose name starts with “j” and contains “n” in their name.
	select EName from Employee
	where EName like 'j%n%';

--5. Display 2nd to 9th character of the given string “SQL Programming”.
	select substring('SQL Programming',2,8);

--6. Display name of the employees whose city name ends with “ney” &contains six characters.
	select EName from Employee 
	where City like '___ney';

--7. Write a query to convert value 15 to string.
	select convert(varchar,15);
	select cast(15 as varchar);

--8. Add department column with varchar (20) to Employee table.
	alter table Employee
	add department varchar(20);

--9. Set the value of department to Marketing who belongs to London city.
	update Employee
	set department='Marketing'
	where City='London';

--10. Display all the employees whose name ends with either “n” or “y”.
	select EName from Employee
	where EName like '%n' or Ename like '%y';

--11. Find smallest integer value that is greater than or equal to 63.1, 63.8 and -63.2.
	select ceiling(63.1),ceiling(63.8),ceiling(-63.2);

--12. Display all employees whose joining date is not available.
	select * from Employee
	where JoiningDate is null;

--13. Display name of the employees in capital letters and city in small letters.
	select upper(EName),lower(City) from Employee;

--14. Change the data type of Ename from varchar (30) to char (30).
	alter table Employee
	alter column EName varchar(20);

--15. Display city wise maximum salary.
	select City,max(Salary) from Employee
	group by City;

--16. Produce output like <Ename> works at <city> and earns <salary> (In single column).
	select Ename + ' works at ' + City + ' and earns ' + cast(Salary as varchar) from Employee;

--17. Find total number of employees whose salary is more than 5000.
	select count(*) from Employee
	where Salary>5000;

--18. Write a query to display first 4 & last 3 characters of all the employees.
	select left(EName,4),right(EName,3) from Employee;

--19. List the city having total salaries more than 15000 and employees joined after 1st January, 2014.
	select City from Employee
	where JoiningDate > '01-JAN-2014'
	group by City
	Having Sum(Salary) > 15000;

--20. Write a query to replace “u” with “oo” in Ename.
	select replace(Ename,'u','oo') from Employee;

--21. Display city with average salaries and total number of employees belongs to each city.
	select City,avg(Salary),count(EID) from Employee
	group by City;

--22. Display total salaries paid to female employees.
	select sum(Salary) from Employee
	where Gender='Female';

--23. Display name of the employees and their experience in years.
	select EName,datediff (year,JoiningDate,getDate()) from Employee;

--24. Remove column department from employee table.
	alter table Employee
	drop column department;

--25. Update the value of city from syndey to null.
	update Employee
	set City=null
	where City='Sydney';

--26. Retrieve all Employee name, Salary & Joining date.
	select EName,Salary,JoiningDate from Employee;

--27. Find out combine length of Ename & Gender.
	select len(EName)+len(Gender) from Employee;

--28. Find the difference between highest & lowest salary.
	select Max(Salary)-Min(Salary) from Employee;

--29. Rename a column from Ename to FirstName.
	sp_rename 'Employee.EName','FirstName';

--30. Rename a table from Employee to EmpMaster.
	sp_rename 'Employee','EmpMaster';