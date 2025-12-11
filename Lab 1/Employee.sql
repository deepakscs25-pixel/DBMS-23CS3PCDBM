create database Employee;
use Employee;
show tables;
create table Department ( DEPTNO int primary key, Dname varchar(20), Dloc varchar(20));
desc Department;
insert into Department values(10,'Accounting','Mumbai');
insert into Department values(20,'Research','Bengaluru');
insert into Department values(30,'Sales','Delhi');
insert into Department values(40,'Operations','Chennai');
select * from Department;
create table Employee (EMPNO int primary key,Ename varchar(30), Mgr_No int, Hire_Date date, Salary int, DEPTNO int, foreign key (DEPTNO) references Department(DEPTNO) on delete cascade);
desc Employee;
create table project( PNO int primary key, Ploc varchar(20), Pname varchar(20));
create table Incentives( EMPNO int,foreign key (EMPNO) references Employee(EMPNO), Incentive_Date date, Incentive_Amount int,primary key(EMPNO,Incentive_Date));
desc Incentives;
drop table Incentives;
create table Assigned_to( EMPNO int,foreign key (EMPNO) references Employee(EMPNO), PNO int, foreign key (PNO) references project(PNO), Job_ROle varchar(30)); 
insert into Employee values(7369,'Adarsh',7902,'2012-12-17',80000,20);
insert into Employee values(7499,'Shruthi',7698,'2013-02-20',16000,30);
insert into Employee values(7521,'Anvitha',7698,'2015-02-22',12500,30);
insert into Employee values(7566,'Tanvir',7839,'2008-04-02',29750,20);
insert into Employee values(7654,'Ramesh',7698,'2014-09-28',12500,30);
insert into Employee values(7698,'Kumar',7839,'2015-05-01',28500,30);
insert into Employee values(7782,'Clark',7839,'2017-06-09',24500,10);
insert into Employee values(7788,'Scott',7566,'2010-12-09',12500,20);
insert into Employee values(7839,'King',NULL,'2009-11-17',99999,10);
insert into Employee values(7844,'Turner',7698,'2010-09-08',15000,30);
insert into Employee values(7876,'Adams',7788,'2013-01-12',11000,20);
insert into Employee values(7900,'James',7698,'2017-12-03',9500,30);
insert into Employee values(7902,'Ford',7566,'2010-12-03',30000,20);
select * from Employee;
insert into Incentives values(7499,'2019-02-01',5000);
insert into Incentives values(7521,'2019-02-01',8000);
insert into Incentives values(7521,'2019-03-01',2500);
insert into Incentives values(7566,'2022-02-01',5070);
insert into Incentives values(7654,'2020-02-01',2000);
insert into Incentives values(7654,'2022-04-01',879);
insert into Incentives values(7698,'2019-03-01',500);
insert into Incentives values(7698,'2020-03-01',9000);
insert into Incentives values(7698,'2022-04-01',4500);
select * from Incentives;

insert into project values (101,'AI-Project','Bengaluru');
insert into project values (102,'Iot','Hyderabad');
insert into project values (103,'BlockChain','Bengaluru');
insert into project values (104,'Data Science','Mysore');
insert into project values (105,'Autonomous Systems','Pune');
select * from project;

insert into Assigned_to values(7499,101,'Software Engineer');
insert into Assigned_to values(7499,102,'Software Engineer');
insert into Assigned_to values(7521,101,'Software Architect');
insert into Assigned_to values(7521,102,'Software Engineer');
insert into Assigned_to values(7566,101,'Project Manager');
insert into Assigned_to values(7654,102,'Sales');
insert into Assigned_to values(7654,103,'Cyber Security');
insert into Assigned_to values(7698,104,'Software Engineer');
insert into Assigned_to values(7839,104,'General Manager');
insert into Assigned_to values(7900,105,'Software Engineer');
select *from Assigned_to;

select EMPNO 
from Assigned_to a
join project p on a.PNO=p.PNO
where p.ploc in ('Hyderabad','Bengaluru','Mysuru');

select m.Ename,count(*)
from Employee e,Employee m
where e.Mgr_no=m.EMPNO
group by m.Ename 
having count(*)=(select max(mycount) from (select count(*) mycount from Employee group by Mgr_No)a);

select *
from Employee m
where m.EMPNO in (select Mgr_No from Employee) And m.Salary > (select avg(Salary) from Employee e where e.Mgr_No = m.EMPNO);

select avg(Salary)
from Employee;

select * from Employee where EMPNO in 
(select distinct m.Mgr_No 
from Employee e,Employee m 
where e.Mgr_No = m.Mgr_No and e.DEPTNO = m.DEPTNO and e.EMPNO in
(select distinct m.Mgr_No from Employee e, Employee m
 where e.Mgr_No = m.Mgr_No and e.DEPTNO=m.DEPTNO));
 
 select * from Incentives;
                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 
 select * from Employee e where e.DEPTNO=(select m.DEPTNO from Employee m where m.EMPNO=e.Mgr_no);
 
 select e.EMPNO from Employee e, Assigned_to a, project p
 where e.EMPNO=a.EMPNO and a.PNO=p.PNO and p.Ploc in('Bengaluru','Hyderabad','Mysuru');