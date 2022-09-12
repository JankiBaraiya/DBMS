--1. Print message like - Error Occur that is: Divide by zero error encountered.
	Begin Try
		select 1/0;
	End Try

	Begin Catch
		Select 'Error Occur that is:' + ERROR_MESSAGE() as ERROR_MSG;
	End Catch


--2. Print error message in insert statement using Error_Message () function: Conversion failed when converting datetime from character string.
	Begin Try
		Declare @date_time_value varchar(100) = '10/06/2022 21:02:04'
		Select CONVERT(datetime,@date_time_value,5) as Conversion
	End Try

	Begin Catch
		select ERROR_MESSAGE() as ERROR_MSG;
	End Catch

--3. Create procedure which prints the error message that “The PLogID is already taken. Try another one”.
	Create Procedure PR_PLog_Taken
		@plogid	int,
		@personName	varchar(50)
	as
	Begin
		Begin Try
			insert into PersonLog
			values(@plogid,@personName,'Insert',Getdate())
		End Try

		Begin Catch
			Print 'The PLogID is already taken. Try another one'
		End Catch
	End

	exec PR_PLog_Taken 1,'xyz'			select * from PersonLog
	exec PR_PLog_Taken 1,'abc'

--4. Create procedure that print the sum of two numbers: take both number as integer & handle exception with all error functions if any one enters string value in numbers otherwise print result.
	create Procedure PR_Addition_Two_No
		@number1	varchar(50),
		@number2	int,
		@Addition	int output
	as
	Begin
		Begin Try
			set @Addition = @number1 + @number2;
		End Try
		
		Begin Catch 
			select 
				ERROR_MESSAGE() as [ERROR MSG],
				ERROR_NUMBER() as [ERROR NO],
				ERROR_LINE() as [ERROR Line],
				ERROR_SEVERITY() as [ERROR Severity],
				ERROR_PROCEDURE() as [ERROR PROCEDURE],
				ERROR_STATE() as [ERROR STATE]
		End Catch
	End

	declare @add int
	exec PR_Addition_Two_No 'a',2,@add output
	print @add

--5. Throw custom exception using stored procedure which accepts PLogID as input & that throws Error like no plogid is available in database.
	create Procedure PR_Find_Plog
		@plogid int
	as
	Begin
		if exists (Select * from PersonLog where PLogID = @plogid)
			print ('PLog ID Available in the DataBase')
		else 
			THROW 50005,'ERROR! No Plog ID with this ID',1
	End

	exec PR_Find_Plog 5

--6. Create cursor with name per_cursor which takes PLogID & PersonName as variable and produce combine output with PLogID & Person Name.
	Declare 
		@plogid int,
		@personname	varchar(250);
	Declare per_cursor CURSOR
	FOR 
		Select PLogID,PersonName from PersonLog;
	open per_cursor;
	FETCH NEXT FROM per_cursor Into
		@plogid,@personname
	While @@FETCH_STATUS=0
		Begin 
			Print Cast (@plogid as Varchar) + '-' + @personname;
			FETCH NEXT FROM per_cursor Into
			@plogid,@personname
		End;
	Close per_cursor;
	Deallocate per_cursor;

--7. Use Table Student (Id, Rno, EnrollmentNo, Name, Branch, University) - Create cursor that updates enrollment column as combination of branch & Roll No. like SOE22CE0001 and so on. (22 is admission year)
	create table Student (
		ID				int,
		Rno				int,
		EnrollmentNo	varchar(50),
		Name			varchar(100),
		Branch			varchar(50),
		University		varchar(150)
	)

	insert into Student
	Values(1,101,'xyz','Janki','CE','DU'),
		  (2,102,'abc','Devanshi','Civil','MU'),
		  (3,103,'pqr','Riya','ME','RK');

	select * from Student


DECLARE
	@branch VARCHAR(50),
	@rno    INT;
DECLARE UPDATE_ENROLLMENT_NO CURSOR
FOR
	SELECT Branch,Rno FROM Student;
OPEN UPDATE_ENROLLMENT_NO;
FETCH NEXT FROM UPDATE_ENROLLMENT_NO INTO
	@branch,
	@rno;
WHILE @@FETCH_STATUS=0
	BEGIN
		UPDATE STUDENT
		 SET EnrollmentNo = 'SOE' + '22' + @branch + CAST(@rno AS VARCHAR)
		 WHERE RNO=@rno;
		FETCH NEXT FROM UPDATE_ENROLLMENT_NO INTO
				@branch,
				@rno;
	END;
CLOSE UPDATE_ENROLLMENT_NO;
DEALLOCATE  UPDATE_ENROLLMENT_NO ;