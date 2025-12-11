create database supplier;
use supplier;
create table supplier( S_id int primary key, Sname varchar (30), City varchar(30));
insert into supplier values(10001,"Acme Widgt","Bengaluru");
insert into supplier values(10002,"Johns","Kolkata");
insert into supplier values(10003,"Vimal","Mumbai");
insert into supplier values(10004,"Reliance","Delhi");
select * from supplier;
create table parts(PID int primary key,Pname varchar(20),color varchar(20));
insert into parts values(20001,"Book","Red");
insert into parts values(20002,"Pen","Red");
insert into parts values(20003,"Pencil","Green");
insert into parts values(20004,"Mobile","Green");
insert into parts values(20005,"Charger","Black");
update parts set Pname='Pencil' where PID=20004;

create table catalog(S_id int, PID int , Cost int, foreign key (S_id) references supplier(S_id), foreign key (PID) references parts(PID), primary key(S_id,PID));
insert into catalog values(10001,20001,10);
insert into catalog values(10001,20002,10);
insert into catalog values(10001,20003,30);
insert into catalog values(10001,20004,10);
insert into catalog values(10001,20005,10);
insert into catalog values(10002,20001,10);
insert into catalog values(10002,20002,20);
insert into catalog values(10003,20003,30);
insert into catalog values(10004,20003,40);
select * from catalog;

select distinct p.Pname
from parts p,catalog c
where p.PID=c.PID;

select s.Sname
from supplier s
where(
(select count(p.PID) from parts p)=
(select count(c.PID) from catalog c where c.S_id=s.S_id)
);

select s.Sname
from supplier s
where ((select count(p.PID) from parts p where color='Red')!=(select count(c.PID) from catalog c,parts p where c.S_id=s.S_id and c.PID=p.PID and p.color='Red'));

select p.Pname from parts p,catalog c,supplier s
where p.PID=c.PID and c.S_id=s.S_id and s.Sname = 'Acme Widgt' and not exists (select * from catalog c1,supplier s1 where p.PID=c1.PID and c1.S_id=s1.S_id and s1.Sname<>'Acme Widgt');

select p.Pname,s.Sname as most_Expensive_part,c.cost
from catalog c,supplier s,parts p
where c.S_id = s.S_id and p.PID=c.PID and cost=(select max(cost) from catalog);

select s.Sname,sum(cost) as total_Value from supplier s,catalog c where s.S_id=c.S_id group by c.S_id;

select s.Sname from supplier s, catalog c where s.S_id = c.S_id and c.cost<20 group by s.Sname,s.S_id having count(c.PID)>=2;

select s.Sname,p.Pname,c.cost 
from supplier s,parts p,catalog c
where s.S_id=c.S_id and p.PID=c.PID and c.cost=(select min(c1.cost) from catalog c1 where c1.PID=c.PID);

create view v1 as select s.Sname,count(c.PID) as Part_count from supplier s,catalog c where s.S_id=c.S_id group by s.Sname;
select * from v1;

create view most_expensive_supplier as 
select p.Pname,s.Sname,c.cost
from parts p,supplier s,catalog c
where p.PID=c.PID and s.S_id=c.S_id and c.cost=(select max(c1.cost) from catalog c1 where c1.PID=c.PID);
select * from most_expensive_supplier;

