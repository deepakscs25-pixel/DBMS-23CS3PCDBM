create database insurance;

use insurance;

create table person ( driver_id varchar(10), name varchar(20), address varchar(40),Primary key(driver_id));
insert into person (driver_id,name,address) values ("A01","Richard","Srinivas nagar");
insert into person (driver_id,name,address) values ("A02","Pradeep","Rajaji nagar");
insert into person (driver_id,name,address) values ("A03","Smith","Ashok nagar");
insert into person (driver_id,name,address) values ("A04","Venu","N R Colony");
insert into person (driver_id,name,address) values ("A05","Jhon","Hanumanth nagar");

select * from person;

create table car(reg_num varchar(20) primary key, model char(20), year int);
insert into car(reg_num,model,year) values ("KA052250", "Indica", 1990);
insert into car(reg_num,model,year) values ("KA031181", "Lancer", 1957);
insert into car(reg_num,model,year) values ("KA095477", "Toyota", 1998);
insert into car(reg_num,model,year) values ("KA053408", "Honda", 2008);
insert into car(reg_num,model,year) values ("KA041702", "Audi", 2005);

select * from car;

create table owns( driver_id varchar(10),
FOREIGN KEY(driver_id) REFERENCES person(driver_id), reg_num varchar(20), foreign key(reg_num) references car(reg_num));
insert into owns(driver_id,reg_num) values ("A01","KA052250");
insert into owns(driver_id,reg_num) values ("A02","KA053408");
insert into owns(driver_id,reg_num) values ("A03","KA031181");
insert into owns(driver_id,reg_num) values ("A04","KA095477");
insert into owns(driver_id,reg_num) values ("A05","KA041702");

select * from owns;

create table participated( driver_id varchar(10), foreign key (driver_id) references person(driver_id),
							reg_num varchar(20), foreign key(reg_num) references car(reg_num),
                            report_num int primary key, damage_amount int) ;

insert into participated( driver_id,reg_num,report_num,damage_amount) values ("A01","KA052250", 11 , 10000);
insert into participated( driver_id,reg_num,report_num,damage_amount) values ("A02","KA053408", 12 , 50000);
insert into participated( driver_id,reg_num,report_num,damage_amount) values ("A03","KA095477", 13 , 25000);
insert into participated( driver_id,reg_num,report_num,damage_amount) values ("A04","KA031181", 14 , 3000);
insert into participated( driver_id,reg_num,report_num,damage_amount) values ("A05","KA041702", 15 , 5000);

select * from participated;

create table accident( report_num int, foreign key(report_num) references participated(report_num), accident_date date, location char(30));
insert into accident(report_num,accident_date,location) values (11, "2003-01-01", "Mysore road");
insert into accident(report_num,accident_date,location) values (12, "2004-02-02", "South end circle");
insert into accident(report_num,accident_date,location) values (13, "2003-01-21", "Bull temple road");
insert into accident(report_num,accident_date,location) values (14, "2008-02-17", "Mysore road");
insert into accident(report_num,accident_date,location) values (15, "2005-03-04", "Kankpura road");

select * from accident;

update participated set damage_amount=25000 where reg_num='KA053408' and report_num='12';
select * from participated;

select count(driver_id)count
from participated ,accident 
where participated.report_num=accident.report_num and 
accident.accident_date like '%2008-02-17';

select accident_date,location
from accident;

select driver_id 
from participated
where damage_amount >=25000;

select *
from participated 
order by damage_amount desc;

select avg(damage_amount)
from participated;

delete from participated 
where damage_amount < (select avg(damage_amount)from participated);