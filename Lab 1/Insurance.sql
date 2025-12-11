create database bank;
use bank;

create table branch(branch_name varchar(30) primary key,branch_city varchar(30), assets int); 

insert into branch(branch_name,branch_city,assets) values("SBI_Chamrajpet","Bengaluru",50000);
insert into branch(branch_name,branch_city,assets) values("SBI_ResidencyRoad","Bengaluru",10000);
insert into branch(branch_name,branch_city,assets) values("SBI_ShivajiRoad","Bombay",20000);
insert into branch(branch_name,branch_city,assets) values("SBI_ParlimentRoad","Delhi",10000);
insert into branch(branch_name,branch_city,assets) values("SBI_Jantarmantar","Delhi",20000);

select * from branch;

create table bankaccount(Accno int, branch_name varchar(30),balance int,foreign key(branch_name) references branch(branch_name),primary key(Accno));
desc bankaccount;

SET SQL_SAFE_UPDATES = 0;

insert into bankaccount(Accno,branch_name,balance) values(1,"SBI_Chamrajpet",2000);
insert into bankaccount(Accno,branch_name,balance) values(2,"SBI_ResidencyRoad",5000);
insert into bankaccount(Accno,branch_name,balance) values(3,"SBI_ShivajiRoad",6000);
insert into bankaccount(Accno,branch_name,balance) values(4,"SBI_ParlimentRoad",9000);
insert into bankaccount(Accno,branch_name,balance) values(5,"SBI_Jantarmantar",8000);
insert into bankaccount(Accno,branch_name,balance) values(6,"SBI_ShivajiRoad",4000);
insert into bankaccount(Accno,branch_name,balance) values(8,"SBI_ResidencyRoad",4000);
insert into bankaccount(Accno,branch_name,balance) values(9,"SBI_ParlimentRoad",3000);
insert into bankaccount(Accno,branch_name,balance) values(10,"SBI_ResidencyRoad",5000);
insert into bankaccount(Accno,branch_name,balance) values(11,"SBI_Jantarmantar",2000);

select * from bankaccount;

create table bankcustomer(customer_name varchar(20) primary key, customerstreet varchar(30),customercity varchar(20));			

insert into bankcustomer(customer_name,customerstreet,customercity) values("Avinash","Bull temple road","Bengaluru");
insert into bankcustomer(customer_name,customerstreet,customercity) values("Dinesh","Bannergatta road","Bengaluru");
insert into bankcustomer(customer_name,customerstreet,customercity) values("Mohan","National college road","Bengaluru");
insert into bankcustomer(customer_name,customerstreet,customercity) values("Nikil","Akbar road","Delhi");		
insert into bankcustomer(customer_name,customerstreet,customercity) values("Ravi","Prithviraj road","Delhi");	

select * from bankcustomer;

create table depositer(customer_name varchar(20), Accno int, foreign key(customer_name) references bankcustomer(customer_name),foreign key(Accno) references bankaccount(Accno));

insert into depositer(customer_name,Accno) values ("Avinash",1);
insert into depositer(customer_name,Accno) values ("Dinesh",2);	
insert into depositer(customer_name,Accno) values ("Nikil",4);
insert into depositer(customer_name,Accno) values ("Ravi",5);
insert into depositer(customer_name,Accno) values ("Avinash",8);
insert into depositer(customer_name,Accno) values ("Nikil",9);
insert into depositer(customer_name,Accno) values ("Dinesh",10);
insert into depositer(customer_name,Accno) values ("Nikil",11);	

select * from depositer;	

create table loan(loan_number int,branch_name varchar(30),Amount int, foreign key(branch_name) references branch(branch_name));
insert into loan(loan_number,branch_name,Amount) values(1,"SBI_Chamrajpet",1000);
insert into loan(loan_number,branch_name,Amount) values(2,"SBI_ResidencyRoad",2000);
insert into loan(loan_number,branch_name,Amount) values(3,"SBI_ShivajiRoad",3000);
insert into loan(loan_number,branch_name,Amount) values(4,"SBI_ParlimentRoad",4000);
insert into loan(loan_number,branch_name,Amount) values(5,"SBI_Jantarmantar",5000);

select * from loan;


select customer_name
from depositer,bankaccount
where depositer.Accno=bankaccount.Accno and bankaccount.branch_name = "SBI_ResidencyRoad"
group by depositer.customer_name having count(depositer.customer_name)>=2;

select customer_name,Accno 
from depositer where Accno in
(Select Accno from bankaccount a,branch b where a.branch_name=b.branch_name and branch_city="Delhi");

delete from bankaccount
where branch_name in 
(select branch_name
from branch 
where branch_city="Bombay");

select * from bankaccount;

select *
from loan
order by Amount desc;

(select customer_name from depositer)
union 
(select customer_name from bankcustomer); 

create view loan_sum (branch_name,total_loan) as select branch_name,sum(Amount) from loan group by branch_name;
select * from loan_sum;

update bankaccount set balance=balance*1.05;
select * from bankaccount;

select distinct customer_name,Accno
from depositer
where Accno in (select Accno from bankaccount,loan where bankaccount.branch_name=loan.branch_name);

select branch_name 
from branch 
where assets > all
(select assets from branch where branch_city="Bengaluru"); 

select branch_name,assets
from branch
where assets > all
(SELECT assets
FROM branch
WHERE branch_city = 'Bengaluru');



