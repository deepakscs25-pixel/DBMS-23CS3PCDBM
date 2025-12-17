create database if not exists chandan;
show databases;
use chandan;


create table person1(driver_id varchar(10),
name varchar(20),address varchar(30),
primary key(driver_id));
desc person1;
insert into person1 values("A01","richard","srinivas nagar");
insert into person1 values("A02","pradeep","rajaji nagar");
insert into person1 values("A03","smith","ashok nagar");
insert into person1 values("A04","venu","nr colony");
insert into person1 values("A05","jhon","hanumanth nagar");
select * from person1;


create table cars (reg_num varchar(10),model varchar(20),year int);
desc cars;
insert into cars values("KA05225","ïndica",1990);
insert into cars values("KA031181","lancer",1957);
insert into cars values("KA095477","toyota",1998);
insert into cars values("KA053408","honda",2008);
insert into cars values("KA041702","audi",2005);
select*from cars;


create table owners(driver_id varchar(10),reg_num varchar(10),
foreign key(driver_id) references person1(driver_id), 
foreign key(reg_num)references cars(reg_num));
desc owners;
insert into owners values("A01","KA05225");
insert into owners values("A02","KA053408");
insert into owners values("A03","KA031181");
insert into owners values("A04","KA095477");
insert into owners values("A05","KA041702");
select *from owners;


create table participated(driver_id varchar (10),
reg_num varchar(10),report_num int primary key,
damage_ammount int,foreign key(driver_id) references person1(driver_id),
foreign key(reg_num)references cars(reg_num));
desc participated;
insert into participated values("A01","KA05225",11,10000);
insert into participated values("A02","KA053408",12,50000);
insert into participated values("A03","KA031181",13,25000);
insert into participated values("A04","KA095477",14,3000);
insert into participated values('A05','KA041702',15,5000);
select *from participated;


create table accident(report_num int,accident_date date,
location varchar(20),
foreign key(report_num) references participated(report_num));
desc accident;
insert into accident values(11,"2003-01-01","mysore road");
insert into accident values(12,"2004-02-02","south end circle ");
insert into accident values(13,"2003-01-21","bull temple road");
insert into accident values(14,"2008-02-17","mysore road");
insert into accident values(15,"2005-03-04","kanakpura road");
select *from accident;


select driver_id from participated where damage_ammount>25000;


update participated set damage_ammount=25000 where report_num=12;
select *from participated;


select count(*) from participated p,
accident a where p.report_num=a.report_num and 
a.accident_date like "%2008-02-17";


select avg(damage_ammount) from participated;

