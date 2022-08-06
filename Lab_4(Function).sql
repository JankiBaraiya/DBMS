	-----Function-----

--1. Create a table valued function which accepts DepartmentID as a parameter & returns a worker table based on DepartmentID.
	
	create Function fnWorkerIDbyDepartmentID(@departmentid int)
	returns table
	as
		return (select * from Person where DepartmentID=@departmentid)

	select * from fnWorkerIDbyDepartmentID (1)

--3. Create a scalar valued function which accepts two parameters start date & end date, and returns a date difference in days.
	create Function fnDayDifference(@startdate datetime , @enddate datetime)
	returns nvarchar(100)
	as
	begin
		return (select cast (datediff(day,@startdate,@enddate) as nvarchar(100)))
	end

	select dbo.fnDayDifference ('2020-05-30','2020-07-25') 


--4. Create a scalar valued function which accepts two parameters year in integer & month in integer and returns total days in passed month & year.
	create Function fnTotalDays(@year int,@month int)
	returns int
	as
	begin
		declare @date datetime = CAST( CAST(@Year AS CHAR(4))
									 + RIGHT('0' + CAST(@Month AS VARCHAR(2)), 2)
									 + '01' AS datetime);
		RETURN DATEDIFF(DAY,
				 DATEADD(MONTH, DATEDIFF(MONTH, 0, @Date), 0),
				 DATEADD(MONTH, DATEDIFF(MONTH, 0, @Date) + 1, 0));
	end

	select dbo.fnTotalDays (2022,5)