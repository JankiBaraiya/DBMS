--mes inserted into log table when record insert

select * from Department

create trigger tr_insert_dept
on Department
for insert
as
begin
	declare @deptid int
	select @deptid=DepartmentID from inserted

	insert into Log
	values ('record with DepartmentID = ' + CAST(@deptid as varchar(50)) + ' is inserted on ' + CAST(getdate() as varchar(50)))
end

insert into Department values(6,'EC','EC','E-Block')

select * from Log

----mes inserted into log table when record update

create trigger tr_update_dept
on Department
for update
as
begin
	declare @deptid int
	select @deptid=DepartmentID from inserted

	insert into Log
	values ('record with DepartmentID = ' + CAST(@deptid as varchar(50)) + ' is updated on ' + CAST(getdate() as varchar(50)))
end

update Department set Location='A-Block' where DepartmentID=6

----mes inserted into log table when record delete

create trigger tr_delete_dept
on Department
for delete
as
begin
	declare @deptid int
	select @deptid=DepartmentID from deleted

	insert into Log
	values ('record with DepartmentID = ' + CAST(@deptid as varchar(50)) + ' is deleted on ' + CAST(getdate() as varchar(50)))
end


delete from Department where DepartmentID=6;