use bank;
show tables;
use insurance;

select *
from participated 
order by damage_amount desc;

select avg(damage_amount) as Average_amount
from participated;

ALTER TABLE accident
DROP FOREIGN KEY accident_ibfk_1;
alter table accident drop column report_num;

DELETE FROM participated
WHERE damage_amount > (
    SELECT avg_damage FROM (
        SELECT AVG(damage_amount) AS avg_damage
        FROM participated
    ) AS temp_avg
);

select * from participated;
select p.name, p.driver_id 
from person p,participated s
where p.driver_id=s.driver_id and damage_amount > (select avg(damage_amount) from participated);

select max(damage_amount) as Maximum_Amount
from participated;

desc participated;
show create table accident;
desc accident;
DROP TABLE accident;
create table accident(report_num int, accident_date date,location varchar(20) ,foreign key (report_num) references participated(report_num) on delete set null);
insert into accident(report_num,accident_date,location) values(11,'01-01-03',"Mysore road");
insert into accident(report_num,accident_date,location) values(12,'2004-02-02',"South end circle");
insert into accident(report_num,accident_date,location) values(13,'2003-01-21',"Bull temple road");
insert into accident(report_num,accident_date,location) values(14,'2008-02-17',"Mysore road");
insert into accident(report_num,accident_date,location) values(15,'2005-03-04',"Kanakpura road");
select * from accident;