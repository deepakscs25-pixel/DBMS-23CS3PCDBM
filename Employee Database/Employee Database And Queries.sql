create database Employee;
use Employee;


create table department(dept_no decimal(2,0),dname varchar(20),dloc varchar(20),primary key(dept_no));
desc department;
insert into department values("10","research","bengaluru");
insert into department values("20","accounting","mumbai");
insert into department values("30","sales","delhi");
insert into department values("40","operation","chennai");
select *from department;


create table employee (emp_no decimal (4,0),ename varchar(20),
mgr_no decimal(4,0),hire_date date,sallary decimal(7,2),
dept_no decimal(2,0),primary key(emp_no),foreign key (dept_no) 
references department (dept_no) on delete cascade on update cascade);
desc employee;
insert into employee values(7369,"adarsh",7902,'2012-12-17', 80000,20);
insert into employee values(7499,"shruthi",7698,'2013-02-20', 16000,30);
insert into employee values(7521,"anvitha",7698,'2015-02-22', 12500,30);
insert into employee values(7566,"tanvir",7839,'2008-04-02', 29750,20);
insert into employee values(7654,"ramesh",7698,'2014-09-28', 12500,30);
insert into employee values(7698,"kumar",7839,'2015-05-01', 28500,30);
insert into employee values(7782,"clark",7839,'2017-06-09', 24500,10);
insert into employee values(7788,"scott",7566,'2010-12-09', 30000,20);
insert into employee values(7839,"king",null,'2009-11-17', 99999.99,10);
insert into employee values(7844,"turner",7698,'2010-09-08', 15000,30);
insert into employee values(7876,"adams",7788,'2013-01-12', 11000,20);
insert into employee values(7900,"james",7698,'2017-12-03', 9500,30);
insert into employee values(7902,"ford",7566,'2010-12-03', 30000,20);
select *from employee;


create table incentive(emp_no decimal(4,0) references 
employee (emp_no) on delete cascade on update cascade,
incentive_date date,incentive_amount decimal(10,2),
primary key (emp_no,incentive_date));
desc incentive;
insert into incentive values(7499,'2019-02-01', 5000);
insert into incentive values(7521,'2019-02-01', 8000);
insert into incentive values(7521,'2019-03-01', 2500);
insert into incentive values(7566,'2022-02-01', 5070);
insert into incentive values(7654,'2020-02-01', 2000);
insert into incentive values(7654,'2022-02-01', 879);
insert into incentive values(7698,'2019-03-01', 500);
insert into incentive values(7698,'2020-03-01', 9000);
insert into incentive values(7698,'2022-04-01', 4500);
select*from incentive;


create table project (pno int primary key,
pname varchar(30)not null,ploc varchar(30));
desc project;
insert into project values(101,"AI project","bengaluru");
insert into project values(102,"IOT","hyderabad");
insert into project values(103,"BLOCKCHAIN","bengaluru");
insert into project values(104,"DATA SCIENCE","mysuru");
insert into project values(105,"AUTONOMUS SYSTEMS","pune");
select *from project;


create table assigned_to
(emp_no decimal(4,0) references employee(emp_no) on delete cascade on update cascade,
pno int references project(pno) on delete cascade on update cascade,
job_role varchar(30),primary key (emp_no,pno));

insert into assigned_to values(7499,101,"software engineer");
insert into assigned_to values(7499,102,"software engineer");
insert into assigned_to values(7521,101,"software architect");
insert into assigned_to values(7521,102,"software engineer");
insert into assigned_to values(7566,101,"project manager");
insert into assigned_to values(7654,102,"sales");
insert into assigned_to values(7654,103,"cyber security");
insert into assigned_to values(7698,104,"software engineer");
insert into assigned_to values(7839,104,"general manager");
insert into assigned_to values(7900,105,"software engineer");
select *from assigned_to;


select m.ename ,count(*) from employee e,employee m 
where e.mgr_no=m.emp_no group by m.ename having count(*)=
(select max(mycount)from (select count(*) mycount from employee group by mgr_no)a);


select emp_no,ename,sallary from employee e 
where e.emp_no in 
(select mgr_no from employee) and e.sallary>
(select avg(sallary)from employee m where m.mgr_no=e.emp_no); 


SELECT DISTINCT m.ename AS Top_Manager, m.dept_no FROM employee e, 
employee m WHERE e.mgr_no = m.emp_no AND e.dept_no = m.dept_no AND m.emp_no IN 
( SELECT e.mgr_no FROM employee );


select *from employee e,incentive i
where e.emp_no=i.emp_no and 2 = ( select count(*)
from incentive j
where i.incentive_amount <= j.incentive_amount );


SELECT *FROM employee E
WHERE E.dept_no = (SELECT E1.dept_no
FROM employee E1
WHERE E1.emp_no=E.mgr_no);


SELECT e.emp_no
FROM employee e, assigned_to a, project p
WHERE e.emp_no = a.emp_no AND a.pno = p.pno
AND p.ploc IN ('BENGALURU', 'HYDERABAD', 'MYSURU');


SELECT distinct e.ename
FROM employee e,incentive i
WHERE (SELECT max(sallary+incentive_amount)
FROM employee,incentive) >= ANY
(SELECT sallary
FROM employee e1
where e.dept_no=e1.dept_no);
