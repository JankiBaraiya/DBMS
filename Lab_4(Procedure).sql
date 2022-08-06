-----Stored Procedure-----

--1. All tables Insert, Update & Delete
--Insert--
	--1.Department
	create proc PR_Department_Insert
		@departmentid	int,
		@departmentname	varchar(100)
	as
	begin
		Insert into Department (DepartmentID,DepartmentName)
		values 
		(
			@departmentid,
			@departmentname	
		)
	end

	exec PR_Department_Insert 1,'Admin'
	exec PR_Department_Insert 2,'IT'
	exec PR_Department_Insert 3,'HR'
	exec PR_Department_Insert 4,'Account'

	select * from Department;


	--2.Designation
	create proc PR_Designation_Insert
		@designation	int,
		@designationname	varchar(100)
	as
	begin
		Insert into Designation(DesignationID,DesignationName)
		values 
		(
			@designation,	
			@designationname
		)
	end

	exec PR_Designation_Insert 11,'Jobber'
	exec PR_Designation_Insert 12,'Welder'
	exec PR_Designation_Insert 13,'clark'
	exec PR_Designation_Insert 14,'Manager'
	exec PR_Designation_Insert 15,'CEO'
	
	select * from Designation

	--3.Person
	create proc PR_Person_Insert
		@firstname		varchar(100),
		@lastname		varchar(100),
		@salary			decimal(8,2),
		@joiningdate	datetime,
		@departmentid	int,
		@designationid	int
	as
	begin
		Insert into Person
		(
			FirstName,
			LastName,
			Salary,
			JoiningDate,
			DepartmentID,
			DesignationID
		)
		values
		(
			@firstname,		
			@lastname,	
			@salary	,	
			@joiningdate,	
			@departmentid,	
			@designationid
		)
	end

	exec PR_Person_Insert 'Rahul','Anshu','56000.00','1990-01-01',1,12
	EXEC PR_Person_Insert'HARDIK','HINSU',18000,'1990-09-25',2,11
	EXEC PR_Person_Insert 'BHAVIN','KAMANI',25000,'1991-05-14',NULL,11
	EXEC PR_Person_Insert 'BHOOMI','PATEL',39000,'2014-02-20',1,13
	EXEC PR_Person_Insert 'ROHIT','RAJGOR',17000,'1990-07-23',2,15
	EXEC PR_Person_Insert 'PRIYA','MEHTA',25000,'1990-10-18',2,NULL
	EXEC PR_Person_Insert 'NEHA','TRIVEDI',18000,'2014-02-20',3,15

	SELECT * FROM PERSON


--Update--
	--1.Department
	CREATE PROCEDURE PR_DEPARMENT_UPDATE
	@DEPARTMENTID	INT,
	@DEPARTMENTNAME	VARCHAR(100)
	AS
	BEGIN
		UPDATE DEPARTMENT SET
			DEPARTMENTID=@DEPARTMENTID,	
			DEPARTMENTNAME=@DEPARTMENTNAME
			WHERE DEPARTMENTID = @DEPARTMENTID
	END

	EXEC PR_DEPARMENT_UPDATE 1,ADMIN1

	--2.Designation
	CREATE PROCEDURE PR_DESIGNATION_UPDATE
	@DESIGNATIONID		INT,
	@DESIGNATIONNAME	VARCHAR(100)
	AS
	BEGIN
		UPDATE DESIGNATION SET
			DESIGNATIONID=@DESIGNATIONID,	
			DESIGNATIONNAME=@DESIGNATIONNAME
			WHERE DESIGNATIONID=@DESIGNATIONID
	END

	EXEC PR_DESIGNATION_UPDATE 11,JOBBER1

	--3.Person
	CREATE PROCEDURE PR_PERSON_UPDATE
	@WORKERID		INT,
	@FIRSTNAME		VARCHAR(100),
	@LASTNAME		VARCHAR(100),
	@SALARY			DECIMAL(8,2),
	@JOININGDATE	DATETIME,
	@DEPARTMENTID	INT,
	@DESIGNATIONID	INT
	AS
	BEGIN
		UPDATE PERSON SET
			FIRSTNAME=@FIRSTNAME,		
			LASTNAME=@LASTNAME,		
			SALARY=@SALARY,			
			JOININGDATE=@JOININGDATE,	
			DEPARTMENTID=@DEPARTMENTID,
			DESIGNATIONID=@DESIGNATIONID
			WHERE WORKERID=@WORKERID
	END

	EXEC PR_PERSON_UPDATE 101,'RAHUL_1','ANSHU_1',56000,'1990-01-01',1,12


--Delete--
	--1.Department
	CREATE PROCEDURE PR_DEPARTMENT_DELETE
	@DEPARTMENTID	INT
	AS
	BEGIN
		DELETE FROM DEPARTMENT
		WHERE DEPARTMENTID=@DEPARTMENTID
	END

	EXEC PR_DEPARTMENT_DELETE 4

	--2.Designation
	CREATE PROCEDURE PR_DESIGNATION_DELETE
	@DESIGNATIONID		INT
	AS
	BEGIN
		DELETE FROM DESIGNATION
		WHERE DESIGNATIONID=@DESIGNATIONID
	END

	EXEC PR_DESIGNATION_DELETE 14

	--3.Person
	CREATE PROCEDURE PR_PERSON_DELETE
	@WORKERID		INT
	AS
	BEGIN
		DELETE FROM PERSON
			WHERE WORKERID=@WORKERID
	END

	EXEC PR_PERSON_DELETE 101


--2. All tables SelectAll (If foreign key is available than do write join and take columns on select list)
	--1.Department
		create proc PR_Department_SelectAll
		as
		begin
			select * from Department
		end

		exec PR_Department_SelectAll

	--2.Designation
		create proc PR_Designation_SelectAll
		as
		begin
			select * from Designation
		end

		exec PR_Designation_SelectAll

	--3.Person
		create Proc PR_Person_SelectAll
		as
		begin
			select p.WorkerID,p.FirstName,p.LastName,p.JoiningDate,p.Salary,d.DepartmentName,de.DesignationName
			from Person as p inner join Department as d
			on p.DepartmentID=d.DepartmentID
			inner join Designation as de
			on p.DesignationID=de.DesignationID
		end

		exec PR_Person_SelectAll

--3. All tables SelectPK
	--1.Department_SelectPK
		create proc PR_Department_SelectPK
			@departmentid	int
		as
		begin
			select * from Department
			where DepartmentID=@departmentid
		end

		exec PR_Department_SelectPK 1

	--2.Designation_SelectPK
		create proc PR_Designation_SelectPK
			@designationid	int
		as
		begin
			select * from Designation
			where DesignationID=@designationid
		end

		exec PR_Designation_SelectPK 11

	--3.Person_SelectPK
		create proc PR_Person_SelectPK
			@workerid	int
		as
		begin
			select * from Person
			where WorkerID=@workerid
		end

		exec PR_Person_SelectPK 102

--4. Create Procedure that takes Department Name & Designation Name as Input and Returns a table with Worker’s First Name, Salary, Joining Date & Department Name.
	create proc PR_Input
		@departmentname		varchar(100),
		@designationname	varchar(100)
	as
	begin
		select p.FirstName,p.Salary,p.JoiningDate,d.DepartmentName
		from Person as p inner join Department as d
		on p.DepartmentID=d.DepartmentID
		inner join Designation as de
		on p.DesignationID=de.DesignationID
		where d.DepartmentName=@departmentname	and
		 de.DesignationName=@designationname
	end

	exec PR_Input 'HR','CEO'

--5. Create Procedure that takes FirstName as an input parameter and displays’ all the details of the worker with their department & designation name.
	create Proc PR_Input1
		@firstname	varchar(100)
	as
	begin
		select p.WorkerID,p.FirstName,p.LastName,p.JoiningDate,p.Salary,d.DepartmentID,d.DepartmentName,de.DesignationID,de.DesignationName
		from Person as p inner join Department as d
		on p.DepartmentID=d.DepartmentID
		inner join Designation as de
		on p.DesignationID=de.DesignationID
		where p.FirstName=@firstname
	end

	exec PR_Input1 'Neha'

--6. Create Procedure which displays department wise maximum, minimum & total salaries.
	create proc PR_Display_deptSalary
	as
	begin
		Select d.DepartmentName,Max(p.Salary) Maximum,Min(p.Salary) Minimum,Sum(p.Salary) Total
		from Person as p inner join Department as d
		on p.DepartmentID=d.DepartmentID
		group by d.DepartmentName
	end

	exec PR_Display_deptSalary