--1. Create INSERT, UPDATE & DELETE Stored Procedures for Person table.
	--insert
create proc PR_Person_Insert
	@personid		int,
	@personname		varchar(50),
	@salary			decimal(8,2),
	@joiningdate	datetime,
	@city			varchar(100),
	@age			int,
	@birthdate		datetime
as
begin
	insert into Person
	(
		PersonId,
		PersonName,
		Salary,
		JoiningDate,
		City,
		Age,
		BirthDate
	)
	values
	(
		@personid,	
		@personname,	
		@salary,	
		@joiningdate,
		@city,		
		@age,		
		@birthdate	
	)
end

exec PR_Person_Insert 101,'XYZ',23000,'2012-09-02','RAJKOT',34,'1994-09-02'

select * from Person;

	--update
create proc PR_Person_Update
	@personid		int,
	@personname		varchar(50),
	@salary			decimal(8,2),
	@joiningdate	datetime,
	@city			varchar(100),
	@age			int,
	@birthdate		datetime
as
begin
	update Person
	set PersonName = @personname,	
		Salary = @salary,		
		JoiningDate=@joiningdate,
		City=@city,		
		Age=@age,
		Birthdate=@birthdate
	where  PersonID = @personid
 end

 exec PR_Person_Update 101,'ABC',29000,'2012-09-02','RAJKOT',34,'1994-09-02'

	--Delete 
create proc PR_Person_Delete
	@peraonid	int
as
begin
	Delete from Person
	where PersonID=@peraonid
end

exec PR_Person_Delete 101


--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the Person table. For that, create a new table PersonLog to log (enter) all operations performed on the Employee table

	--INSERT
create Trigger TR_Insert
on Person
for Insert
as
begin
	declare @personid INT
	declare @personname VARCHAR(50)
	select  @personid = PersonID,
			@personname = PersonName
		from inserted

	Insert into PersonLog
	VALUES(@personid,@personname,'INSERT',GETDATE())
END

Insert into Person 
values (101,'JAKE',2000.00,'2002-05-09','TOKYO',28,'1990-01-09')

INSERT INTO Person 
VALUES(102,'JAY',20340,'2003-06-19','LONDON',18,'2001-03-29')

SELECT * FROM PersonLog

	--UPDATE
alter Trigger TR_Update
on Person
for Update
as
begin
	declare @personid INT
	declare @personname VARCHAR(50)
	select  @personid = PersonID,
			@personname = PersonName
		from inserted

	Insert into PersonLog
	VALUES(@personid,@personname,'UPDATE',GETDATE())
END

Update Person
set City = 'rajkot' 
where PersonID = 101

Update Person
set PersonName = 'Janu' 
where PersonID = 101

SELECT * FROM PersonLog

	--DELETE
create Trigger TR_Delete
on Person
for delete
as
begin
	declare @personid INT
	declare @personname VARCHAR(50)
	select  @personid = PersonID,
			@personname = PersonName
		from deleted

	Insert into PersonLog
	VALUES(@personid,@personname,'DELETE',GETDATE())
END

delete from Person
where PersonID = 101

SELECT * FROM PERSONLOG


--3.Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Person table. For that, log all operation performed on the Employee table into PersonLog.

	--INSERT
create Trigger TR_Insert_INSTEAD_OF
on Person
INSTEAD OF Insert
as
begin
	declare @personid INT
	declare @personname VARCHAR(50)
	select  @personid = PersonID,
			@personname = PersonName
		from inserted

	Insert into PersonLog
	VALUES(@personid,@personname,'INSERT',GETDATE())
END

insert into Person
values (101,'JAY',20000.00,'2003-06-19','LONDON',18,'2001-03-29')

	--UPDATE
create Trigger TR_Update_INSTEAD_OF
on Person
INSTEAD OF Update
as
begin
	declare @personid INT
	declare @personname VARCHAR(50)
	select  @personid = PersonID,
			@personname = PersonName
		from inserted

	Insert into PersonLog
	VALUES(@personid,@personname,'UPDATE',GETDATE())
END

Update Person
set PersonName='JARK'
where PersonID=101

	--DELETE
create Trigger TR_Delete_INSTEAD_OF
on Person
INSTEAD OF delete
as
begin
	declare @personid INT
	declare @personname VARCHAR(50)
	select  @personid = PersonID,
			@personname = PersonName
		from deleted

	Insert into PersonLog
	VALUES(@personid,@personname,'DELETE',GETDATE())
END








--4.  Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints ‘Record deleted successfully from PersonLog’
Create trigger TR_Delete_PersonLog
on PersonLog
after Delete
as 
begin
	Print('Record deleted successfully from PersonLog');
end

delete from PersonLog
where PLogID = 15

--5. Create INSERT trigger on person table, which calculates the age and update that age in Person table
alter Trigger TR_Insert1
on Person
For Insert
as
begin
	declare @personID int;
	declare @birthdate datetime;

	select @personID = PersonID from inserted
	select @birthdate = Birthdate from inserted

	update Person
	set Age = CONVERT (int,datediff(year,@birthdate,GETDATE()))
	where PersonID = @personID
end




