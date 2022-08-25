--Create Trigger to print msg when row is inserted

alter trigger tr_emp_mes_insert
on EmpMaster
for insert
as
begin
	print 'record is inserted'
	--select * from inserted
end

insert into EmpMaster values (11,'xyz','male','1990-02-25',35000,'rajkot')
insert into EmpMaster values (12,'abc','female','1990-02-25',44000,'Jamnagar')

----Create Trigger to print msg when row is update

create trigger tr_emp_mes_update
on EmpMaster
for update
as
begin
	print 'record is update'
end

update EmpMaster set City='rajkot' where EID=12


----Create Trigger to print msg when row is delete

create trigger tr_emp_mes_delete
on EmpMaster
for delete
as
begin
	print 'record is delete'
end

delete from EmpMaster where EID=12

