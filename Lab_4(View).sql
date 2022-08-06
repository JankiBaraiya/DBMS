--VIEWS--
	--1. Create a view that display first 100 workers detailS.
	 CREATE VIEW FIRST_100
	 AS
	  SELECT TOP 100 * FROM Person;
	
	SELECT * FROM FIRST_100

	--2. Create a view that displays designation wise maximum, minimum & total salaries.
	create VIEW Designation_Salary
	AS
	  SELECT D.DesignationName,MAX(P.Salary) AS MAXIMUM,MIN(P.Salary) AS MINIMUM,SUM(P.Salary) AS TOTAL
	   FROM Designation AS D INNER JOIN Person AS P
	   ON D.DesignationID=P.DesignationID
	   GROUP BY DesignationName;

	SELECT * FROM DESIGNATION_SALARY

	--3. Create a view that displays Worker’s first name with their salaries & joining date, it also displays duration column which is difference of joining date with respect to current date.

	create VIEW DISPLAY_WORKER
	AS
	  SELECT FirstName,Salary,JoiningDate,DATEDIFF(YEAR,JoiningDate,GETDATE()) AS DURATION 
	  FROM PERSON

	SELECT * FROM DISPLAY_WORKER

	--4. Create a view which shows department & designation wise total number of workers.

	CREATE VIEW TOTAL_WORKERS
	AS
	  SELECT D.DepartmentName,COUNT(P.FirstName) AS TOTAL
	  FROM Person AS P INNER JOIN Department AS D
	  ON P.DepartmentID=D.DepartmentID 
	  GROUP BY D.DepartmentName;

	  SELECT * FROM TOTAL_WORKERS

	create VIEW TOTAL_WORKERS_DE
	AS
	  SELECT DE.DesignationName,COUNT(P.FirstName) AS TOTAL
	  FROM Person AS P INNER JOIN Designation AS DE
	  ON P.DesignationID=DE.DesignationID 
	  GROUP BY DE.DesignationName;
    
	SELECT * FROM TOTAL_WORKERS_DE

	--5. Create a view that displays worker names who don’t have either in any department or designation.

	CREATE VIEW WORKER_DETAIL
	AS
	  SELECT FirstName
	  FROM PERSON
	  WHERE DepartmentID IS NULL OR DesignationID IS NULL;

	   SELECT * FROM WORKER_DETAIL