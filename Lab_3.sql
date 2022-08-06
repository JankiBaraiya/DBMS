select * from Department;
select * from Person;

--1. Find all persons with their department name & code. 
	select p.PersonName,d.DepartmentName,d.DepartmentCode
	from Person as p inner join Department as d
	on p.DepartmentID=d.DepartmentID;

--2. Give department wise maximum & minimum salary with department name.
	select Department.DepartmentName,Max(Person.Salary) as Maximum ,Min(Person.Salary) as Minimum
	from Person inner join Department
	on Person.DepartmentID=Department.DepartmentID
	group by Department.DepartmentName;

--3. Find all departments whose total salary is exceeding 100000.
	select Department.DepartmentName,SUM(Person.Salary) as Total_Dept_Salary
	from Person inner join Department
	on Person.DepartmentID=Department.DepartmentID
	group by Department.DepartmentName
	having SUM(Person.Salary)>100000;

--4. Retrieve person name, salary & department name who belongs to Jamnagar city.
	select Person.PersonName,Person.Salary,Department.DepartmentName
	from Person inner join Department
	on Person.DepartmentID=Department.DepartmentID
	where Person.City='Jamnagar';

--5. Find all persons who does not belongs to any department.
	select Person.PersonName from Person Left Outer Join Department
	on Person.DepartmentID=Department.DepartmentID
	where Person.DepartmentID is null;

--6. Find department wise person counts.
	select d.DepartmentName,COUNT(p.PersonID) as person
	from Person as p inner join Department as d
	on p.DepartmentID=d.DepartmentID
	group by d.DepartmentName;

--7. Find average salary of person who belongs to Ahmedabad city.
	select AVG(Salary) as AVG_Salary 
	from Person
	where City='Ahmedabad';

--8. Produce Output Like: <PersonName> earns <Salary> from department <DepartmentName> monthly.(In single column)
	select p.PersonName + ' earns ' + cast(p.Salary as varchar) + ' from department ' + d.DepartmentName + ' monthly '
	from Person as p inner join Department as d
	on p.DepartmentID=d.DepartmentID

--9. List all departments who have no persons.
	select d.DepartmentName
	from Person as p  left outer join Department as d
	on p.DepartmentID=d.DepartmentID
	group by d.DepartmentName
	having COUNT(p.DepartmentID) = 0;

--10. Find city & department wise total, average & maximum salaries.
		---department Wise---
	select d.DepartmentName,sum(p.Salary) as total,AVG(p.Salary) as Avg,Max(p.Salary) as Maximum
	from Person as p inner join Department as d
	on p.DepartmentID=d.DepartmentID
	group by d.DepartmentName;

		---City Wise---
	select City,sum(Salary) as total,AVG(Salary) as Avg,Max(Salary) as Maximum from Person 
	group by City;

--11. Display Unique city names.
	select Distinct city from Person;

--12. List out department names in which more than two persons.
	select d.DepartmentName,COUNT(p.PersonID)
	from Person as p right outer join Department as d
	on p.DepartmentID=d.DepartmentID
	group by d.DepartmentName
	having COUNT(p.DepartmentID)>2;

--13. Combine person name’s first three characters with city name’s last three characters in single column.
	select LEFT(PersonName,3) + RIGHT(City,3) from Person;

--14. Give 10% increment in Computer department employee’s salary.
	update Person
	set Salary=((Salary*10)/100) + Salary
	where DepartmentID = (select DepartmentID from Department
						where DepartmentName='computer');

--15. Display all the person name’s who’s joining dates difference with current date is more than 365 days.
	select PersonName from Person
	where (getdate()-JoiningDate) > 365;