--------Lab 1--------

Select * from Student;

--1. Display Name of Student who belongs to either Semester 3 or 5. (Use IN & OR)
	select Name from Student
	where Sem=3 or Sem=5;

	select Name from Student
	where Sem in (3,5);

--2. Find Student Name & Enrollment No in which Student Id between 103 to 105.
	select Name,EnrollmentNo from Student
	where StuId Between 103 and 105;
	
	select Name,EnrollmentNo from Student
	where StuId>103 and StuId<105;

--3. Find Student Name & Enrollment No with their Email Who belongs to 5th Semester.
	select Name,EnrollmentNo,Email from Student
	where Sem=5;

--4. Display All the Details of first three students.
	select top 3 * from Student;

--5. Display Name & Enrollment no of first 30% Students who’s contact number ends with 7.
	select top 30 percent Name,EnrollmentNo from Student
	where ContactNo like '%7';

--6. Display Unique Semesters.
	select distinct Sem from Student;

--7. Retrieve All the Students who have no Enrollment.
	select * from Student
	where EnrollmentNo is null;

--8. Find All Students whose Name does not start with ‘V’.
	select * from Student 
	where Name not like 'v%';

--9. Find All Students in which Email Contains ‘3@G’ & Only Six Characters.
	select * from Student
	where Email like '%3@G%' and Email like '______';

--10. Find Out All the Students whose First Name Starts with F And third character must be R.
	select * from Student
	where Name like 'f_r%';

--11. Find All the Student Details whose Contact No contains 877.
	select * from Student
	where ContactNo like '%877%';

--12. Display Student Name in Which Student belongs to Semester 3 & Contact Number Does Not Contains 8 & 9.
	select Name from Student
	where Sem=3 and ContactNo not like '%8%9%';

--13. Find Students who born after date 01-01-1990.
	select * from Student
	where BirthDate>'1990-jan-01';

--14. Update Division to BCX-5 & Semester 5 whose Student Id Is 102.
	Update  Student
	set Division='BCX-5',Sem=5
	where StuId=102;

--15. Change the Student’s Name to Firoz Sherasiya in which Email is Firoz.Me@Gmail.Com & Contact No is 8885999922.
	update Student
	set Name='Firoz Serasiya'
	where Email='Firoz.Me@Gmail.Com';

--16. Add one more Column City Varchar (50) in Student Table.
	alter table Student 
	Add City Varchar(50);

--17. Remove All BCX-3 Division Students.
	delete from Student
	where Division='BCX-3';

--18. Change Column Name Email to EmailAddress.
	sp_Rename 'Student.Email','EmailAddress';

--19. Write an SQL query to clone a new table Student_New from Student table with all data.
	select * into Student_New from Student;

	Select * from Student_New;

--20. Remove All the Data from Student Table Using Truncate.
	Truncate table Student;